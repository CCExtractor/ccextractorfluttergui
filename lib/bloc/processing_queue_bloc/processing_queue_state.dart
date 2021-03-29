part of 'processing_queue_bloc.dart';

abstract class ProcessingQueueState extends Equatable {
  const ProcessingQueueState();

  @override
  List<Object> get props => [];
}

class ProcessingQueueInitial extends ProcessingQueueState {}

class CurrentlyProcessingFile extends ProcessingQueueState {
  final String filePath;

  CurrentlyProcessingFile(this.filePath);
  @override
  List<Object> get props => [filePath];
}

class ProcessingQueue extends ProcessingQueueState {
  final List<String> filePaths;

  ProcessingQueue(this.filePaths);
  @override
  List<Object> get props => [filePaths];
}

// class ProcessedFilesState extends ProcessingQueueState {
//   final List<String> filePaths;
//   ProcessedFilesState(this.filePaths);
//   @override
//   List<Object> get props => [filePaths];
// }
