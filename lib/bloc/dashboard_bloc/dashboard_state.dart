part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class NewFileSelectedState extends DashboardState {
  final List<XFile> files;

  NewFileSelectedState({required this.files});
  NewFileSelectedState copyWith({
    required List<XFile> files,
  }) =>
      NewFileSelectedState(files: files);
  @override
  List<Object> get props => [files];
}

class SelectedFileAlreadyPresentState extends DashboardState {
  final XFile file;

  SelectedFileAlreadyPresentState(this.file);
  @override
  List<Object> get props => [file];
}
