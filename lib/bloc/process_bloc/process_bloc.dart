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
  ProcessBloc() : super(ProcessState(progress: "0"));
  List<String> logs = [];
  StreamSubscription? _stdErrorSubscription;
  StreamSubscription? _stdOutSubscription;
  Video? _temp;
  final RegExp progressReg = RegExp(r"###PROGRESS#(\d+)", multiLine: true);
  final RegExp subtitlesReg = RegExp(r"###SUBTITLE###(.+)", multiLine: true);
  final RegExp timeReg = RegExp(r"###TIME#(.+)", multiLine: true);
  final RegExp summaryReg = RegExp(r"\[(.*?)\]", multiLine: true);
  final RegExp logsReg =
      RegExp(r"###SUBTITLE###(.+)|###TIME#(.+)", multiLine: true);
  int currentlyProcessingFile = 0;
  List<String> filePaths = [];
  List<String?> videoDetails = [];
  @override
  Stream<ProcessState> mapEventToState(
    ProcessEvent event,
  ) async* {
    if (event is AddFilesToPrcessingQueue) {
      filePaths = event.filePaths;
      print("starting index $currentlyProcessingFile");
      add(
        ProcessStarted(CustomProcess(event.filePaths[currentlyProcessingFile])),
      );
    }
    if (event is CustomProcessEnded) {
      if (filePaths.length - 1 > currentlyProcessingFile) {
        currentlyProcessingFile++;
        add(AddFilesToPrcessingQueue(filePaths));
      } else {
        currentlyProcessingFile = 0;
        add(FinsihedProcessingAllFiles());
      }
    }
    if (event is FinsihedProcessingAllFiles) {
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
              print(i[1]);
            }
          }
          if (logsReg.hasMatch(update)) {
            for (RegExpMatch i in logsReg.allMatches(update)) {
              if (i[1] != null) logs.add(i[1]!);
              if (i[2] != null) logs.add(i[2]!);
              // logs.add(i[1]!);
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
            _temp = Video(
              videoDetails[26]!,
              videoDetails[27]!.substring(9),
              videoDetails[28]!.substring(9),
              videoDetails[11]!.substring(10),
              videoDetails[10]!.substring(15),
            );
            add(
              VideoDetails(_temp!),
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
          video: state.video,
          logs: state.logs,
        );
    }

    if (event is LogsUpdate) {
      yield state.copyWith(
        progress: state.progress,
        video: state.video,
        logs: event.logs,
      );
    }
    if (event is VideoDetails) {
      yield state.copyWith(
        progress: state.progress,
        video: event.video,
        logs: state.logs,
      );
    }
  }
}
