part of 'updater_bloc.dart';

abstract class UpdaterEvent extends Equatable {
  const UpdaterEvent();

  @override
  List<Object> get props => [];
}

class CheckForUpdates extends UpdaterEvent {
  final String currentVersion;

  CheckForUpdates(this.currentVersion);

  @override
  List<Object> get props => [currentVersion];
}

class DownloadUpdate extends UpdaterEvent {
  final String downloadURl;

  DownloadUpdate(this.downloadURl);
  @override
  List<Object> get props => [downloadURl];
}
