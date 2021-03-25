part of 'process_bloc.dart';

@immutable
abstract class ProcessEvent {
  const ProcessEvent();
  List<Object> get props => [];
}

class ProcessStarted extends ProcessEvent {
  final CustomProcess customProcess;

  ProcessStarted(this.customProcess);
  @override
  List<Object> get props => [customProcess];
}

class ProcessProgressUpdate extends ProcessEvent {
  const ProcessProgressUpdate(this.progress);

  final String progress;

  @override
  List<Object> get props => [progress];
}

class ProcessSubtitlesUpdate extends ProcessEvent {
  const ProcessSubtitlesUpdate(this.subitiles);

  final String subitiles;

  @override
  List<Object> get props => [subitiles];
}

class VideoDetails extends ProcessEvent {
  final Video video;

  VideoDetails(this.video);

  @override
  List<Object> get props => [video];
}
