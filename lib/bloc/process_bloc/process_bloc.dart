import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';

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
    on<ProcessEvent>(_onEvent, transformer: sequential());
  }

  Stream<ProcessState> _extractNext(Emitter<ProcessState> emit) async* {
    if (!state.started || state.current != null || state.queue.isEmpty) {
      if (state.queue.isEmpty) {
        // We need to show user that all files have finished processing
        // but also keep the queue ready with the orignal list incase
        // user wants to rerun ccx on those files. But if the user adds any files
        // after he finished processing the first x files selected, process the
        // next y new selected files because its more likely that the user wants
        // to process the new files than the old files that might have changed
        //and he wants to ccx on all of them. Handling these new y files is done
        // in `if event is ProcessFilesSubmitted` more info there.

        // TLDR; this part handles the setting of queue and processed to original
        // incase the user wants to rerun the files.
        yield state.copyWith(
          queue: state.orignalList,
          processed: state.processed,
          started: false,
          progress: '0',
          current: null,
        );
      }
      return;
    }
    final file = state.queue.first;
    yield state.copyWith(
      current: file,
      queue: state.queue.skip(1).toList(),
      progress: '0',
    );
    unawaited(
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
      ),
    );
  }

  Stream<ProcessState> _extractOnNetwork(String type, String location,
      String tcppassword, String tcpdesc, Emitter<ProcessState> emit) async* {
    unawaited(
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
      ),
    );
  }

  Stream<ProcessState> _extractFilesInSplitMode(
      Emitter<ProcessState> emit) async* {
    unawaited(
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
      ),
    );
  }

  FutureOr<void> _onEvent(
      ProcessEvent event, Emitter<ProcessState> emit) async {
    if (event is StartAllProcess) {
      emit(state.copyWith(
        current: state.current,
        // This equality checks if the queue and originalList are same which
        // means that the user has not added any new y files or they have been
        // already processed too and we can set the processed list to empty
        // which means all file processing will start from top and all files
        // will get their proper ProgressIndicators. If the equality test fails,
        // that means that the user has added y new files which have not been
        // processed yet, so we need to keep the tick mark of the previously
        // proccessed x files as it is.
        processed: state.queue == state.orignalList ? [] : state.processed,
        started: true,
      ));
      _extractNext(emit);
    } else if (event is StartProcessInSplitMode) {
      emit(state.copyWith(current: state.current, started: true));
      _extractFilesInSplitMode(emit);
    } else if (event is StopAllProcess) {
      // stops everything
      try {
        _extractor.cancelRun();
      } catch (_) {}
      emit(state.copyWith(
        current: null,
        queue: state.orignalList,
        processed: [], // We don't need ticks when we stop so discard processed files list.
        progress: '0',
        started: false,
      ));
    } else if (event is ProcessKill) {
      try {
        _extractor.cancelRun();
      } catch (_) {}
      emit(state.copyWith(
        current: state.current,
        orignalList: state.orignalList
            .where((element) => element != event.file)
            .toList(),
        queue: state.queue.where((element) => element != event.file).toList(),
      ));
    } else if (event is ProcessRemoveAll) {
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
    } else if (event is ProcessFileExtractorProgress) {
      emit(state.copyWith(current: state.current, progress: event.progress));
    } else if (event is ProcessFileVideoDetails) {
      emit(state.copyWith(
          current: state.current, videoDetails: event.videoDetails));
    } else if (event is ProcessFileExtractorOutput) {
      emit(state.copyWith(
        current: state.current,
        log: state.log.followedBy([event.log]).toList(),
      ));
    } else if (event is ProcessFileComplete) {
      if (state.current == event.file) {
        emit(state.copyWith(
          current: null,
          log: state.queue.isNotEmpty ? [] : state.log,
          processed: state.processed.followedBy([event.file]).toList(),
          exitCode: null,
        ));
        _extractNext(emit);
      }
    } else if (event is SplitModeProcessComplete) {
      emit(state.copyWith(
          current: null,
          log: state.log,
          exitCode: null,
          started: false,
          progress: '100'));
    } else if (event is ProcessFilesSubmitted) {
      emit(state.copyWith(
        current: state.current,
        orignalList: List.from(state.orignalList)..addAll(event.files),
        processed: state.processed,
        // Here we can have two cases, one all selected x files have finished
        // then started is set to false by the _extractNext() state. Second case
        // could be that the user has added y new files.
        // if state.started is true, that means currently the x files are being
        // processed and user has added y new files, which will get processed in
        // state.queue automatically.
        // if state.started is false, that means that the first x files have
        // finsihed processing and then he user adds y new files, so new queue
        // need to be set to event.files instead of originalList.
        // state.started can also be false when the users selects x files from
        // one folder and then clicks add files again to select y files from
        // some different folder, so we should also check if the processed files
        // list is empty if no its the above case, if it is empty that means the
        // user has selected x and y files from different folders by clicking
        // add files button 2 times and we should start running ccx on all the
        // files

        // TLDR; this part handles the y new files thingy mentioned in
        // _extractNext func comments.
        queue: state.started || state.processed.isEmpty
            ? state.queue.followedBy(event.files).toList()
            : event.files,
      ));
    } else if (event is ProcessFileRemoved) {
      emit(state.copyWith(
        current: state.current,
        orignalList: state.orignalList
            .where((element) => element != event.file)
            .toList(),
        queue: state.queue.where((element) => element != event.file).toList(),
      ));
    } else if (event is GetCCExtractorVersion) {
      String ccxVersion = await _extractor.getCCExtractorVersion;
      emit(state.copyWith(
        current: state.current,
        version: ccxVersion,
      ));
    } else if (event is ProcessError) {
      emit(state.copyWith(current: state.current, exitCode: event.exitCode));
    } else if (event is ResetProcessError) {
      emit(state.copyWith(current: state.current, exitCode: null));
    } else if (event is ProcessOnNetwork) {
      _extractOnNetwork(
          event.type, event.location, event.tcppassword, event.tcpdesc, emit);
    }
  }
}
