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
          orignalList: [],
          queue: [],
          processed: [],
          log: [],
          videoDetails: [],
          started: false,
          progress: '0',
          current: null,
        ));

  Stream<ProcessState> _extractNext() async* {
    if (!state.started || state.current != null || state.queue.isEmpty) {
      // TODO: Add clear List button, show only latest 1000 lines of logs to prevent lag.
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
    unawaited(_extractor
        .extractFile(
          file,
          listenProgress: (progress) =>
              add(ProcessFileExtractorProgress(progress)),
          listenOutput: (line) => add(ProcessFileExtractorOutput(line)),
          listenVideoDetails: (videoDetails) =>
              add(ProcessFileVideoDetails(videoDetails)),
        )
        .then((value) => add(ProcessFileComplete(file))));
  }

  @override
  Stream<ProcessState> mapEventToState(ProcessEvent event) async* {
    if (event is ProcessStarted) {
      yield state.copyWith(
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
      );
      yield* _extractNext();
    } else if (event is ProcessStopped) {
      yield state.copyWith(
        current: null,
        queue: state.orignalList,
        processed: [], // We don't need ticks when we stop so discard processed files list.
        progress: '0',
        started: false,
      );
    } else if (event is ProcessFileExtractorProgress) {
      yield state.copyWith(current: state.current, progress: event.progress);
    } else if (event is ProcessFileVideoDetails) {
      yield state.copyWith(
          current: state.current, videoDetails: event.videoDetails);
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
        // need to be set to event.files instead of originalList

        // TLDR; this part handles the y new files thingy mentioned in
        // _extractNext func comments.
        queue: state.started
            ? state.queue.followedBy(event.files).toList()
            : event.files,
      );
    } else if (event is ProcessFileRemoved) {
      yield state.copyWith(
        current: state.current,
        orignalList: state.orignalList
            .where((element) => element != event.file)
            .toList(),
        queue: state.queue.where((element) => element != event.file).toList(),
      );
    }
  }
}
