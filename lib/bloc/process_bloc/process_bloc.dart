// Package imports:
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';

// Project imports:
import 'package:ccxgui/models/ccextractor.dart';

part 'process_event.dart';
part 'process_state.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  final CCExtractor _extractor = CCExtractor();

  ProcessBloc()
      : super(ProcessState(
          queue: [],
          processed: [],
          log: [],
          started: false,
          progress: '0',
          current: null,
        ));

  Stream<ProcessState> _extractNext() async* {
    if (!state.started || state.current != null || state.queue.isEmpty) {
      return;
    }
    final file = state.queue.first;
    yield state.copyWith(
      current: file,
      queue: state.queue.skip(1).toList(),
      progress: '0',
    );
    unawaited(_extractor
        .extractFile(
          file,
          listenOutput: (line) => add(ProcessFileExtractorOutput(line)),
          listenProgress: (progress) =>
              add(ProcessFileExtractorProgress(progress)),
        )
        .then((value) => add(ProcessFileComplete(file))));
  }

  @override
  Stream<ProcessState> mapEventToState(ProcessEvent event) async* {
    if (event is ProcessStarted) {
      yield state.copyWith(
        current: state.current,
        started: true,
      );
      yield* _extractNext();
    } else if (event is ProcessStopped) {
      yield state.copyWith(
        current: state.current,
        started: false,
      );
    } else if (event is ProcessFileExtractorProgress) {
      print(event.progress);
      yield state.copyWith(current: state.current, progress: event.progress);
    } else if (event is ProcessFileExtractorOutput) {
      yield state.copyWith(
        current: state.current,
        log: state.log.followedBy([event.log]).toList(),
      );
    } else if (event is ProcessFileComplete) {
      if (state.current == event.file) {
        yield state.copyWith(
          current: null,
          processed: state.processed.followedBy([event.file]).toList(),
        );
        yield* _extractNext();
      }
    } else if (event is ProcessFilesSubmitted) {
      yield state.copyWith(
        current: state.current,
        queue: state.queue.followedBy(event.files).toList(),
      );
    } else if (event is ProcessFileRemoved) {
      yield state.copyWith(
        current: state.current,
        queue: state.queue.where((element) => element != event.file).toList(),
      );
    }
  }
}
