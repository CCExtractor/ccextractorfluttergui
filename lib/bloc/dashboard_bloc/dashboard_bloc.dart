import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

/// Handles selecting and removing files.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(files: [], alreadyPresent: false)) {
    on<NewFileAdded>(_onNewFileAdded);
    on<FileRemoved>(_onFileRemoved);
    on<RemoveAllFiles>(_onRemoveAllFiles);
  }

  void _onNewFileAdded(NewFileAdded event, Emitter<DashboardState> emit) {
    List<XFile> finalEventList = List.from(event.files);
    bool alreadyPresent = false;
    for (var stateFile in state.files) {
      for (var eventFile in event.files) {
        if (eventFile.path == stateFile.path) {
          alreadyPresent = true;
          finalEventList.remove(eventFile);
        }
      }
    }
    if (alreadyPresent) {
      emit(state.copyWith(
          files: List.from(state.files)..addAll(finalEventList),
          alreadyPresent: true));
    } else {
      emit(state.copyWith(
          files: List.from(state.files)..addAll(event.files),
          alreadyPresent: false));
    }
  }

  void _onFileRemoved(FileRemoved event, Emitter<DashboardState> emit) {
    emit(state.copyWith(
        files: List.from(state.files)..remove(event.file),
        alreadyPresent: false));
  }

  void _onRemoveAllFiles(RemoveAllFiles event, Emitter<DashboardState> emit) {
    emit(state.copyWith(files: [], alreadyPresent: false));
  }
}
