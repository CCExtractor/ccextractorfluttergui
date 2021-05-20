import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

/// Handles selecting and removing files.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    final currentState = state;
    if (event is NewFileAdded) {
      if (currentState is NewFileSelectedState) {
        List<XFile> currentFiles = List.from(currentState.files);
        for (XFile file in event.files) {
          if (!currentFiles.contains(file)) {
            currentFiles.add(file);
          } else {
            yield SelectedFileAlreadyPresentState(file);
          }
        }
        yield NewFileSelectedState(
          files: currentFiles,
        );
      } else if (currentState is DashboardInitial) {
        List<XFile> currentFiles = [];
        for (XFile file in event.files) {
          currentFiles.add(file);
        }
        yield NewFileSelectedState(
          files: currentFiles,
        );
      }
    }
    if (event is FileRemoved) {
      if (currentState is NewFileSelectedState) {
        List<XFile> currentFiles = List.from(currentState.files);
        currentFiles.remove(event.file);
        yield NewFileSelectedState(files: currentFiles);
      }
    }
  }
}
