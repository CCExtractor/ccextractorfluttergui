// part of 'process_bloc.dart';

// @immutable
// abstract class ProcessEvent {
//   const ProcessEvent();
//   List<Object> get props => [];
// }

// class ProcessStarted extends ProcessEvent {
//   final CustomProcess customProcess;

//   ProcessStarted(this.customProcess);
//   @override
//   List<Object> get props => [customProcess];
// }

// class ProcessProgressUpdate extends ProcessEvent {
//   const ProcessProgressUpdate(this.progress);

//   final String progress;

//   @override
//   List<Object> get props => [progress];
// }

// class VideoDetails extends ProcessEvent {
//   final Video video;

//   VideoDetails(this.video);

//   @override
//   List<Object> get props => [video];
// }

// class LogsUpdate extends ProcessEvent {
//   final List<String> logs;
//   LogsUpdate(this.logs);
//   @override
//   List<Object> get props => [logs];
// }

// class AddFilesToPrcessingQueue extends ProcessEvent {
//   final List<String> filePaths;

//   /// if the event has been added from startAll or other events
//   final bool startAll;
//   AddFilesToPrcessingQueue(this.filePaths, this.startAll);
//   @override
//   List<Object> get props => [filePaths, startAll];
// }

// class CustomProcessEnded extends ProcessEvent {
//   final int processedFileIndex;

//   CustomProcessEnded(this.processedFileIndex);
//   @override
//   List<Object> get props => [processedFileIndex];
// }

// class FileRemovedFromProcessingQueue extends ProcessEvent {
//   final int removedFileIndex;

//   FileRemovedFromProcessingQueue(this.removedFileIndex);
//   @override
//   List<Object> get props => [removedFileIndex];
// }

// class FinsihedProcessingAllFiles extends ProcessEvent {}
