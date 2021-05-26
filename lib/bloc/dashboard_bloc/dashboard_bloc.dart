// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

/// Handles selecting and removing files.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(files: [], alreadyPresent: false));
  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is NewFileAdded) {
      List<XFile> finalEventList = List.from(event.files);
      bool alreadyPresent = false;
      // TODO: find a better way to do this check.
      for (var stateFile in state.files) {
        for (var eventFile in event.files) {
          if (eventFile.path == stateFile.path) {
            alreadyPresent = true;
            finalEventList.remove(eventFile);
          }
        }
      }
      if (alreadyPresent) {
        yield state.copyWith(
            files: List.from(state.files)..addAll(finalEventList),
            alreadyPresent: true);
      } else {
        yield state.copyWith(
            files: List.from(state.files)..addAll(event.files));
      }
    } else if (event is FileRemoved) {
      yield state.copyWith(files: List.from(state.files)..remove(event.file));
    }
  }
}
