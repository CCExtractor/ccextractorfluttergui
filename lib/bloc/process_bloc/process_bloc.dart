import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/repositories/ccextractor.dart';

part 'process_event.dart';
part 'process_state.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  final CCExtractor _extractor = CCExtractor();

  ProcessBloc()
      : super(ProcessState(
          orignalList: [],
          queue: [],
          processed: [],
          log: [],
          videoDetails: [],
          started: false,
          progress: '0',
          current: null,
          version: '0',
        )) {
    on<StartAllProcess>(_onStartAllProcess);
    on<StartProcessInSplitMode>(_onStartProcessInSplitMode);
    on<StopAllProcess>(_onStopAllProcess);
    on<ProcessKill>(_onProcessKill);
    on<ProcessRemoveAll>(_onProcessRemoveAll);
    on<ProcessFileExtractorProgress>(_onProcessFileExtractorProgress);
    on<ProcessFileVideoDetails>(_onProcessFileVideoDetails);
    on<ProcessFileExtractorOutput>(_onProcessFileExtractorOutput);
    on<ProcessFileComplete>(_onProcessFileComplete);
    on<SplitModeProcessComplete>(_onSplitModeProcessComplete);
    on<ProcessFilesSubmitted>(_onProcessFilesSubmitted);
    on<ProcessFileRemoved>(_onProcessFileRemoved);
    on<GetCCExtractorVersion>(_onGetCCExtractorVersion);
    on<ProcessError>(_onProcessError);
    on<ResetProcessError>(_onResetProcessError);
    on<ProcessOnNetwork>(_onProcessOnNetwork);
  }

  void _extractNext(Emitter<ProcessState> emit) {
    if (!state.started || state.current != null || state.queue.isEmpty) {
      if (state.queue.isEmpty) {
        emit(state.copyWith(
          queue: state.orignalList,
          processed: state.processed,
          started: false,
          progress: '0',
          current: null,
        ));
      }
      return;
    }
    final file = state.queue.first;
    emit(state.copyWith(
      current: file,
      queue: state.queue.skip(1).toList(),
      progress: '0',
    ));
    _extractor
        .extractFile(
      file,
      listenProgress: (progress) =>
          add(ProcessFileExtractorProgress(progress)),
      listenOutput: (line) => add(ProcessFileExtractorOutput(line)),
      listenVideoDetails: (videoDetails) =>
          add(ProcessFileVideoDetails(videoDetails)),
    )
        .then(
      (value) {
        if (value != 0) {
          add(ProcessError(value));
        }
        add(ProcessFileComplete(file));
      },
    );
  }

  void _extractOnNetwork(String type, String location, String tcppassword,
      String tcpdesc, Emitter<ProcessState> emit) {
    _extractor
        .extractFileOverNetwork(
      type: type,
      location: location,
      tcpdesc: tcpdesc,
      tcppasswrd: tcppassword,
      listenProgress: (progress) =>
          add(ProcessFileExtractorProgress(progress)),
      listenOutput: (line) => add(ProcessFileExtractorOutput(line)),
      listenVideoDetails: (videoDetails) =>
          add(ProcessFileVideoDetails(videoDetails)),
    )
        .then(
      (value) {
        if (value != 0) {
          add(ProcessError(value));
        }
      },
    );
  }

  void _extractFilesInSplitMode(Emitter<ProcessState> emit) {
    _extractor
        .extractFilesInSplitMode(
      state.orignalList,
      listenProgress: (progress) =>
          add(ProcessFileExtractorProgress(progress)),
      listenOutput: (line) => add(ProcessFileExtractorOutput(line)),
      listenVideoDetails: (videoDetails) =>
          add(ProcessFileVideoDetails(videoDetails)),
    )
        .then(
      (value) {
        if (value != 0) {
          add(ProcessError(value));
        }
        add(SplitModeProcessComplete());
      },
    );
  }

  void _onStartAllProcess(StartAllProcess event, Emitter<ProcessState> emit) {
    emit(state.copyWith(
      current: state.current,
      processed: state.queue == state.orignalList ? [] : state.processed,
      started: true,
    ));
    _extractNext(emit);
  }

  void _onStartProcessInSplitMode(
      StartProcessInSplitMode event, Emitter<ProcessState> emit) {
    emit(state.copyWith(current: state.current, started: true));
    _extractFilesInSplitMode(emit);
  }

  void _onStopAllProcess(StopAllProcess event, Emitter<ProcessState> emit) {
    try {
      _extractor.cancelRun();
    } catch (_) {}
    emit(state.copyWith(
      current: null,
      queue: state.orignalList,
      processed: [],
      progress: '0',
      started: false,
    ));
  }

  void _onProcessKill(ProcessKill event, Emitter<ProcessState> emit) {
    try {
      _extractor.cancelRun();
    } catch (_) {}
    emit(state.copyWith(
      current: state.current,
      orignalList:
          state.orignalList.where((element) => element != event.file).toList(),
      queue: state.queue.where((element) => element != event.file).toList(),
    ));
  }

  void _onProcessRemoveAll(ProcessRemoveAll event, Emitter<ProcessState> emit) {
    try {
      _extractor.cancelRun();
    } catch (_) {}
    emit(state.copyWith(
      current: null,
      progress: '0',
      processed: [],
      queue: [],
      orignalList: [],
      started: false,
      exitCode: null,
      log: [],
      videoDetails: [],
    ));
  }

  void _onProcessFileExtractorProgress(
      ProcessFileExtractorProgress event, Emitter<ProcessState> emit) {
    emit(state.copyWith(current: state.current, progress: event.progress));
  }

  void _onProcessFileVideoDetails(
      ProcessFileVideoDetails event, Emitter<ProcessState> emit) {
    emit(state.copyWith(
        current: state.current, videoDetails: event.videoDetails));
  }

  void _onProcessFileExtractorOutput(
      ProcessFileExtractorOutput event, Emitter<ProcessState> emit) {
    emit(state.copyWith(
      current: state.current,
      log: state.log.followedBy([event.log]).toList(),
    ));
  }

  void _onProcessFileComplete(
      ProcessFileComplete event, Emitter<ProcessState> emit) {
    if (state.current == event.file) {
      emit(state.copyWith(
        current: null,
        log: state.queue.isNotEmpty ? [] : state.log,
        processed: state.processed.followedBy([event.file]).toList(),
        exitCode: null,
      ));
      _extractNext(emit);
    }
  }

  void _onSplitModeProcessComplete(
      SplitModeProcessComplete event, Emitter<ProcessState> emit) {
    emit(state.copyWith(
        current: null,
        log: state.log,
        exitCode: null,
        started: false,
        progress: '100'));
  }

  void _onProcessFilesSubmitted(
      ProcessFilesSubmitted event, Emitter<ProcessState> emit) {
    emit(state.copyWith(
      current: state.current,
      orignalList: List.from(state.orignalList)..addAll(event.files),
      processed: state.processed,
      queue: state.started || state.processed.isEmpty
          ? state.queue.followedBy(event.files).toList()
          : event.files,
    ));
  }

  void _onProcessFileRemoved(
      ProcessFileRemoved event, Emitter<ProcessState> emit) {
    emit(state.copyWith(
      current: state.current,
      orignalList:
          state.orignalList.where((element) => element != event.file).toList(),
      queue: state.queue.where((element) => element != event.file).toList(),
    ));
  }

  Future<void> _onGetCCExtractorVersion(
      GetCCExtractorVersion event, Emitter<ProcessState> emit) async {
    String ccxVersion = await _extractor.getCCExtractorVersion;
    emit(state.copyWith(
      current: state.current,
      version: ccxVersion,
    ));
  }

  void _onProcessError(ProcessError event, Emitter<ProcessState> emit) {
    emit(state.copyWith(current: state.current, exitCode: event.exitCode));
  }

  void _onResetProcessError(
      ResetProcessError event, Emitter<ProcessState> emit) {
    emit(state.copyWith(current: state.current, exitCode: null));
  }

  void _onProcessOnNetwork(ProcessOnNetwork event, Emitter<ProcessState> emit) {
    _extractOnNetwork(
        event.type, event.location, event.tcppassword, event.tcpdesc, emit);
  }
}
