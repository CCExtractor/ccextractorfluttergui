import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'processing_queue_event.dart';
part 'processing_queue_state.dart';

class ProcessingQueueBloc
    extends Bloc<ProcessingQueueEvent, ProcessingQueueState> {
  ProcessingQueueBloc() : super(ProcessingQueueInitial());

  @override
  Stream<ProcessingQueueState> mapEventToState(
    ProcessingQueueEvent event,
  ) async* {
    final currentState = state;
    if (event is AddFilesToPrcessingQueue) {
      print("${event.filePaths}");
    }
  }
}
