part of 'processing_queue_bloc.dart';

abstract class ProcessingQueueEvent extends Equatable {
  const ProcessingQueueEvent();

  @override
  List<Object> get props => [];
}

class AddFilesToPrcessingQueue extends ProcessingQueueEvent {
  final List<String> filePaths;

  AddFilesToPrcessingQueue(this.filePaths);
  @override
  List<Object> get props => [filePaths];
}

// class RemoveFileFromProcessingQueue extends ProcessingQueueEvent {
//   final int fileIndex;

//   RemoveFileFromProcessingQueue(this.fileIndex);
//   @override
//   List<Object> get props => [fileIndex];
// }

