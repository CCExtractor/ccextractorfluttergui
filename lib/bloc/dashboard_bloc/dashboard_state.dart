part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class NewFileSelectedState extends DashboardState {
  final List<String> fileNames;
  final List<String> filePaths;

  NewFileSelectedState({required this.fileNames, required this.filePaths});
  NewFileSelectedState copyWith({
    required List<String> fileNames,
    required List<String> filePaths,
  }) =>
      NewFileSelectedState(fileNames: fileNames, filePaths: filePaths);
  @override
  List<Object> get props => [fileNames, filePaths];
}

class SelectedFileAlreadyPresentState extends DashboardState {
  final String fileName;

  SelectedFileAlreadyPresentState(this.fileName);
  @override
  List<Object> get props => [fileName];
}
