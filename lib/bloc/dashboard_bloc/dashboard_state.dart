part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final List<XFile> files;
  final bool alreadyPresent;
  DashboardState({required this.files, required this.alreadyPresent});

  DashboardState copyWith({
    required List<XFile>? files,
    bool? alreadyPresent,
  }) =>
      DashboardState(
        files: files ?? this.files,
        alreadyPresent: alreadyPresent ?? this.alreadyPresent,
      );
  @override
  List<Object?> get props => [files, alreadyPresent];
}
