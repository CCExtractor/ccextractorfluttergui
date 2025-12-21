import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:ccxgui/utils/logger.dart';

part 'updater_event.dart';
part 'updater_state.dart';

class UpdaterBloc extends Bloc<UpdaterEvent, UpdaterState> {
  UpdaterBloc() : super(UpdaterState('0.0', '0.0', false, '', '')) {
    on<CheckForUpdates>(_onCheckForUpdates);
    on<DownloadUpdate>(_onDownloadUpdate);
  }

  static const apiUrl =
      'https://api.github.com/repos/CCExtractor/ccextractor/releases';

  Future<void> _onCheckForUpdates(
      CheckForUpdates event, Emitter<UpdaterState> emit) async {
    try {
      var url = Uri.parse(apiUrl);
      String changelog = '';
      int currentVersionIndex = 0;
      http.Response response = await http.get(url);

      if (response.statusCode != 200) {
        logger.e('Failed to check for updates: HTTP ${response.statusCode}');
        return;
      }

      var data = jsonDecode(response.body);

      if (data is! List || data.isEmpty) {
        logger.e('Invalid response format from GitHub API');
        return;
      }

      for (var i = 0; i < data.length; i++) {
        final tagName = data[i]['tag_name']?.toString();
        if (tagName != null &&
            tagName.length > 1 &&
            event.currentVersion == tagName.substring(1)) {
          currentVersionIndex = i;
        }
      }
      for (var i = 0; i < currentVersionIndex; i++) {
        changelog += '\n${data[i]['body'] ?? ''}';
      }

      final firstRelease = data[0];
      final tagName = firstRelease['tag_name']?.toString();
      if (tagName == null || tagName.length < 2) {
        logger.e('Invalid tag name in release data');
        return;
      }

      String latestVersion = tagName.substring(1);

      final assets = firstRelease['assets'];
      if (assets is! List || assets.isEmpty) {
        logger.w('No download assets found in latest release');
        return;
      }

      String downloadURL = assets[0]['browser_download_url']?.toString() ?? '';

      bool updateAvailable =
          _compareVersions(latestVersion, event.currentVersion);
      emit(state.copyWith(
        currentVersion: event.currentVersion,
        latestVersion: latestVersion,
        updateAvailable: updateAvailable,
        downloadURL: downloadURL,
        changelog: changelog,
      ));
    } catch (e, stackTrace) {
      logger.e('Error checking for updates', error: e, stackTrace: stackTrace);
    }
  }

  /// Compare version strings. Returns true if latest > current.
  bool _compareVersions(String latest, String current) {
    try {
      return double.parse(latest) > double.parse(current);
    } catch (_) {
      // If parsing fails, do string comparison
      return latest.compareTo(current) > 0;
    }
  }

  Future<void> _onDownloadUpdate(
      DownloadUpdate event, Emitter<UpdaterState> emit) async {
    await launchUrl(Uri.parse(event.downloadURl));
  }
}
