// part of 'process_bloc.dart';

// class ProcessState extends Equatable {
//   final String? progress;
//   final Video video;
//   final List<String> logs;
//   final int? currentIndex;
//   final List<int> comepletedIndices;
//   final bool finishedAll;
//   ProcessState(
//       {this.progress,
//       required this.video,
//       required this.logs,
//       this.currentIndex,
//       required this.finishedAll,
//       required this.comepletedIndices});
//   ProcessState copyWith({
//     String? progress,
//     Video? video,
//     List<String>? logs,
//     int? currentIndex,
//     required bool finishedAll,
//     required List<int> comepletedIndices,
//   }) =>
//       ProcessState(
//         progress: progress ?? this.progress,
//         video: video ?? this.video,
//         logs: logs ?? this.logs,
//         currentIndex: currentIndex ?? this.currentIndex,
//         comepletedIndices: comepletedIndices,
//         finishedAll: finishedAll,
//       );
//   @override
//   List<Object?> get props =>
//       [progress, video, logs, currentIndex, comepletedIndices, finishedAll];
// }
