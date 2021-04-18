import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    final currentState = state;
    if (event is NewFileAdded) {
      if (currentState is NewFileSelectedState) {
        List<String> namesList = List.from(currentState.fileNames);
        List<String> pathsList = List.from(currentState.filePaths);
        for (XFile file in event.files) {
          if (!pathsList.contains(file.path)) {
            namesList.add(file.name);
            pathsList.add(file.path);
          } else
            // ignore: curly_braces_in_flow_control_structures
            yield SelectedFileAlreadyPresentState(file.name);
        }
        yield NewFileSelectedState(
          fileNames: namesList,
          filePaths: pathsList,
        );
      } else if (currentState is DashboardInitial) {
        List<String> namesList = [];
        List<String> pathsList = [];
        for (XFile file in event.files) {
          namesList.add(file.name);
          pathsList.add(file.path);
        }
        yield NewFileSelectedState(
          fileNames: namesList,
          filePaths: pathsList,
        );
      }
    }
    if (event is FileRemoved) {
      if (currentState is NewFileSelectedState) {
        List<String> namesList = List.from(currentState.fileNames);
        List<String> pathsList = List.from(currentState.filePaths);
        namesList.removeAt(event.removedFileIndex);
        pathsList.removeAt(event.removedFileIndex);
        yield NewFileSelectedState(fileNames: namesList, filePaths: pathsList);
      }
    }
  }
}
