part of 'processing_queue_bloc.dart';

abstract class ProcessingQueueEvent extends Equatable {
  const ProcessingQueueEvent();

  @override
  List<Object> get props => [];
}



class FileRemovedFromQueue extends ProcessingQueueEvent {
  final String filePath;
  FileRemovedFromQueue(this.filePath);
  @override
  List<Object> get props => [filePath];
}

class FileProcessed extends ProcessingQueueEvent {
  final String filePath;

  FileProcessed(this.filePath);
  @override
  List<Object> get props => [filePath];
}
