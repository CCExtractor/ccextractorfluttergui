part of 'processing_queue_bloc.dart';

abstract class ProcessingQueueState extends Equatable {
  const ProcessingQueueState();
  
  @override
  List<Object> get props => [];
}

class ProcessingQueueInitial extends ProcessingQueueState {}

