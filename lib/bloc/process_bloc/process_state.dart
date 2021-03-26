part of 'process_bloc.dart';

class ProcessState extends Equatable {
  final String? progress;
  final Video? video;
  final List<String>? logs;
  ProcessState({this.progress, this.video, this.logs});
  ProcessState copyWith({
    String? progress,
    Video? video,
    List<String>? logs,
  }) =>
      ProcessState(
        progress: progress ?? this.progress,
        video: video ?? this.video,
        logs: logs ?? this.logs,
      );
  @override
  List<Object?> get props => [progress, video, logs];
}
