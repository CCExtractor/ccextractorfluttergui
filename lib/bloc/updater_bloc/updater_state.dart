part of 'updater_bloc.dart';

class UpdaterState {
  final String currentVersion;
  final String latestVersion;
  final bool updateAvailable;
  final String changelog;
  final String downloadURL;
  UpdaterState(this.currentVersion, this.latestVersion, this.updateAvailable,
      this.changelog, this.downloadURL);

  UpdaterState copyWith({
    String? currentVersion,
    String? latestVersion,
    bool? updateAvailable,
    String? changelog,
    String? downloadURL,
  }) {
    return UpdaterState(
      currentVersion ?? this.currentVersion,
      latestVersion ?? this.latestVersion,
      updateAvailable ?? this.updateAvailable,
      changelog ?? this.changelog,
      downloadURL ?? this.downloadURL,
    );
  }
}
