part of 'process_bloc.dart';

class ProcessState extends Equatable {
  final String? subtitles;
  final String? progress;
  final Video? video;
  ProcessState({this.subtitles, this.progress, this.video});
  ProcessState copyWith({
    String? subtitles,
    String? progress,
    Video? video,
  }) =>
      ProcessState(
        subtitles: subtitles ?? this.subtitles,
        progress: progress ?? this.progress,
        video: video ?? this.video,
      );
  @override
  List<Object?> get props => [subtitles, progress, video];
}
