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

class StartCustomProcess extends DashboardEvent {
  final String filePath;
  StartCustomProcess(this.filePath);
  @override
  List<Object> get props => [filePath];
}
