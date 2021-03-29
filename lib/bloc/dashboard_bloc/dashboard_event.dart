part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class NewFileAdded extends DashboardEvent {
  final List<XFile> files;

  NewFileAdded(this.files);

  @override
  List<Object> get props => [files];
}

/// Remove file from selected files in UI only, to remove from processing, check processing_bloc
class FileRemoved extends DashboardEvent {
  final int removedFileIndex;
  FileRemoved(this.removedFileIndex);
  @override
  List<Object> get props => [removedFileIndex];
}
