import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'processing_queue_event.dart';
part 'processing_queue_state.dart';

class ProcessingQueueBloc
    extends Bloc<ProcessingQueueEvent, ProcessingQueueState> {
  ProcessingQueueBloc() : super(ProcessingQueueInitial());

  @override
  Stream<ProcessingQueueState> mapEventToState(
    ProcessingQueueEvent event,
  ) async* {
    final List<String> filesProcessed = [];
    // if (event is AddFilesToPrcessingQueue) {
    //   print("AddFilesToPrcessingQueue:${event.filePaths}");
                        
    // }
    // if (event is FileProcessed) {
    //   filesProcessed.add(event.filePath);
    //   yield ProcessedFilesState(filesProcessed);
    // }
  }
}


/// TODO: how to add FileProcessed? 
/// first listen to processBloc and when it emits CustomProcessFinished(filePath)
/// add the FileProcessed event with the help of BlocListner
/// Then when processQueue bloc gets the event it will add it in a local filesProcessed variable
/// Now why do we need this? Suppose the users adds 1,2,3 with AddFilesToQueue, then when 1 is processed,
/// we will get 1 in filesProcessed variable. Suppose the user deleted 3 while processing 2, AddFilesToQueue will show
/// 1,2 in the list. But now 1 is already over so we will remove all the files from filesProcessed
/// REMEMBER TO CLEAR FILESPROCESSED VARIABLE ONCE ALL THE FILES ARE DONE PROCESSING  