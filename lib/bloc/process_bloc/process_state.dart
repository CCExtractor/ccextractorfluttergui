part of 'process_bloc.dart';

class ProcessState extends Equatable {
  final List<XFile> orignalList;
  final List<XFile> processed;
  final List<XFile> queue;
  final List<String> log;
  final String progress;
  final List<String> videoDetails;
  final XFile? current;
  final bool started;

  const ProcessState({
    required this.orignalList,
    required this.queue,
    required this.processed,
    required this.videoDetails,
    required this.log,
    required this.started,
    required this.progress,
    required this.current,
  });

  ProcessState copyWith({
    List<XFile>? orignalList,
    List<XFile>? processed,
    List<XFile>? queue,
    List<String>? log,
    List<String>? videoDetails,
    bool? started,
    String? progress,
    required XFile? current,
  }) =>
      ProcessState(
        orignalList: orignalList ?? this.orignalList,
        queue: queue ?? this.queue,
        processed: processed ?? this.processed,
        log: log ?? this.log,
        started: started ?? this.started,
        progress: progress ?? this.progress,
        videoDetails: videoDetails ?? this.videoDetails,
        current: current,
      );

  @override
  List<Object?> get props => [
        queue,
        processed,
        log,
        current,
        started,
        progress,
        videoDetails,
        orignalList
      ];
}
