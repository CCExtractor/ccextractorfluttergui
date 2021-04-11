import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ccxgui/models/custom_process.dart';
import 'package:ccxgui/models/video.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'process_event.dart';
part 'process_state.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  ProcessBloc()
      : super(ProcessState(
          progress: "0",
          comepletedIndices: [],
          finishedAll: false,
          logs: ["To start, please select files and click start all"],
          video: Video("", "", "", "", ""),
        ));
  StreamSubscription? _stdErrorSubscription;
  StreamSubscription? _stdOutSubscription;
  final RegExp progressReg = RegExp(r"###PROGRESS#(\d+)", multiLine: true);
  final RegExp subtitlesReg = RegExp(r"###SUBTITLE###(.+)", multiLine: true);
  final RegExp timeReg = RegExp(r"###TIME#(.+)", multiLine: true);
  final RegExp summaryReg = RegExp(r"\[(.*?)\]", multiLine: true);
  final RegExp logsReg =
      RegExp(r"###SUBTITLE###(.+)|###TIME#(.+)", multiLine: true);
  int currentlyProcessingFile = 0;
  List<String> logs = [];
  List<String> filePaths = [];
  List<String?> videoDetails = [];
  List<int> comepletedIndices = [];
  bool finishedAll = false;
  Video video = Video("", "", "", "", "");
  @override
  Stream<ProcessState> mapEventToState(
    ProcessEvent event,
  ) async* {
    if (event is AddFilesToPrcessingQueue) {
      if (event.startAll) {
        logs = [];
        filePaths = [];
        videoDetails = [];
        comepletedIndices = [];
        finishedAll = false;
      }
      filePaths = event.filePaths;
      print("starting index $currentlyProcessingFile");
      String currentFile = event.filePaths[currentlyProcessingFile];
      add(
        ProcessStarted(CustomProcess(currentFile)),
      );
    }
    if (event is CustomProcessEnded) {
      if (filePaths.length - 1 > currentlyProcessingFile) {
        // -1 here because start 0 is already counted.
        videoDetails = [];
        video = Video("", "", "", "", "");
        comepletedIndices.add(currentlyProcessingFile);
        currentlyProcessingFile++;
        add(AddFilesToPrcessingQueue(filePaths, false));
      } else {
        comepletedIndices.add(currentlyProcessingFile);
        currentlyProcessingFile = 0;
        add(FinsihedProcessingAllFiles());
      }
    }
    if (event is FileRemovedFromProcessingQueue) {
      filePaths.removeAt(event.removedFileIndex);
      add(AddFilesToPrcessingQueue(filePaths, false));
    }
    if (event is FinsihedProcessingAllFiles) {
      finishedAll = true;
      print("FINSIHED ALL");
    }

    if (event is ProcessStarted) {
      await _stdErrorSubscription?.cancel();
      await _stdOutSubscription?.cancel();
      await event.customProcess.startprocess();
      _stdErrorSubscription = event.customProcess.processStdError().listen(
        (update) {
          if (progressReg.hasMatch(update)) {
            for (RegExpMatch i in progressReg.allMatches(update)) {
              add(ProcessProgressUpdate(i[1]!));
            }
          }
          if (logsReg.hasMatch(update)) {
            for (RegExpMatch i in logsReg.allMatches(update)) {
              if (i[1] != null) logs.add(i[1]!);
              if (i[2] != null) logs.add(i[2]!);
              add(LogsUpdate(logs));
            }
          }
        },
      );
      _stdOutSubscription = event.customProcess.processStdOut().listen(
        (update) {
          if (summaryReg.hasMatch(update)) {
            for (RegExpMatch i in summaryReg.allMatches(update)) {
              videoDetails.add(i[1]);
            }
          }

          if (videoDetails.length > 26) {
            video = Video(
              videoDetails[26]!,
              videoDetails[27]!.substring(9),
              videoDetails[28]!.substring(9),
              videoDetails[11]!.substring(10),
              videoDetails[10]!.substring(15),
            );
            add(
              VideoDetails(video),
            );
          }
        },
      );
    }

    if (event is ProcessProgressUpdate) {
      if (int.parse(event.progress) == 100) {
        add(CustomProcessEnded(currentlyProcessingFile));
      } else
        yield state.copyWith(
          progress: event.progress,
          video: video,
          logs: state.logs,
          currentIndex: currentlyProcessingFile,
          comepletedIndices: comepletedIndices,
          finishedAll: finishedAll,
        );
    }

    if (event is LogsUpdate) {
      yield state.copyWith(
        progress: state.progress,
        video: video,
        logs: event.logs,
        currentIndex: currentlyProcessingFile,
        comepletedIndices: comepletedIndices,
        finishedAll: finishedAll,
      );
    }
    if (event is VideoDetails) {
      yield state.copyWith(
        progress: state.progress,
        video: video,
        logs: state.logs,
        currentIndex: currentlyProcessingFile,
        comepletedIndices: comepletedIndices,
        finishedAll: finishedAll,
      );
    }
  }
}
