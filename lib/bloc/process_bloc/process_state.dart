part of 'process_bloc.dart';

class ProcessState extends Equatable {
  final List<XFile> originalList;
  final List<XFile> processed;
  final List<XFile> queue;
  final List<String> log;
  final String progress;
  final List<String> videoDetails;
  final XFile? current;
  final bool started;
  final String? version;
  final int? exitCode;
  const ProcessState({
    required this.originalList,
    required this.queue,
    required this.processed,
    required this.videoDetails,
    required this.log,
    required this.started,
    required this.progress,
    required this.current,
    required this.version,
    this.exitCode,
  });

  ProcessState copyWith({
    List<XFile>? originalList,
    List<XFile>? processed,
    List<XFile>? queue,
    List<String>? log,
    List<String>? videoDetails,
    bool? started,
    String? progress,
    String? version,
    required XFile? current,
    int? exitCode,
  }) =>
      ProcessState(
          originalList: originalList ?? this.originalList,
          queue: queue ?? this.queue,
          processed: processed ?? this.processed,
          log: log ?? this.log,
          started: started ?? this.started,
          progress: progress ?? this.progress,
          videoDetails: videoDetails ?? this.videoDetails,
          version: version ?? this.version,
          current: current,
          exitCode: exitCode);

  @override
  List<Object?> get props => [
        queue,
        processed,
        log,
        current,
        started,
        progress,
        videoDetails,
        originalList,
        version,
        exitCode,
      ];
}
