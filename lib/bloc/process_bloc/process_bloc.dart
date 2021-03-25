import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ccxgui/models/custom_process.dart';
import 'package:ccxgui/models/video.dart';
import 'package:ccxgui/models/video.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'process_event.dart';
part 'process_state.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  ProcessBloc() : super(ProcessState(progress: "0"));
  List temp = [];
  StreamSubscription? _stdErrorSubscription;
  StreamSubscription? _stdOutSubscription;
  Video? _temp;
  RegExp progressReg = RegExp(r"###PROGRESS#(\d+)", multiLine: true);
  RegExp subtitlesReg = RegExp(r"###SUBTITLE#(\d.+)", multiLine: true);
  RegExp summaryReg = RegExp(r"\[(.*?)\]", multiLine: true);
  List<String?> videoDetails = [];
  @override
  Stream<ProcessState> mapEventToState(
    ProcessEvent event,
  ) async* {
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
          if (subtitlesReg.hasMatch(update)) {
            for (RegExpMatch i in subtitlesReg.allMatches(update)) {
              String subs = i[1]!.replaceAll('#', ' ');
              subs =
                  subs.substring(0, 5) + "-" + subs.substring(6, subs.length);
              add(ProcessSubtitlesUpdate(subs));
            }
          }
        },
      );
      _stdOutSubscription = event.customProcess.processStdOut().listen(
        (update) {
          if (summaryReg.hasMatch(update)) {
            for (RegExpMatch i in summaryReg.allMatches(update)) {
              videoDetails.add(i[1]);  //TODO: kinda broken rn, need to find a better way to know if getting initialData is finished.
            }
          }
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
        },
      );
    }

    if (event is ProcessProgressUpdate) {
      yield state.copyWith(
          progress: event.progress, subtitles: state.subtitles);
    }
    if (event is ProcessSubtitlesUpdate) {
      yield state.copyWith(
          progress: state.progress, subtitles: event.subitiles);
    }
    if (event is VideoDetails) {
      yield state.copyWith(
          progress: state.progress,
          subtitles: state.subtitles,
          video: event.video);
    }
  }
}
