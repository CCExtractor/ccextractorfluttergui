import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

part 'updater_event.dart';
part 'updater_state.dart';

class UpdaterBloc extends Bloc<UpdaterEvent, UpdaterState> {
  UpdaterBloc() : super(UpdaterState('0.0', '0.0', false, '', ''));
  static const URL =
      'https://api.github.com/repos/CCExtractor/ccextractor/releases';
  @override
  Stream<UpdaterState> mapEventToState(
    UpdaterEvent event,
  ) async* {
    if (event is CheckForUpdates) {
      var url = Uri.parse(URL);
      String changelog = '';
      int currentVersionIndex = 0;
      http.Response response = await http.get(url);
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        if (event.currentVersion ==
            data[i]['tag_name'].toString().substring(1)) {
          currentVersionIndex = i;
        }
      }
      for (var i = 0; i < currentVersionIndex; i++) {
        changelog += '\n' + data[i]['body'].toString();
      }
      String latestVersion = data[0]['tag_name'].toString().substring(1);
      String downloadURL =
          data[0]['assets'][0]['browser_download_url'].toString();

      bool updateAvailable =
          double.parse(latestVersion) > double.parse(event.currentVersion);
      yield state.copyWith(
        currentVersion: event.currentVersion,
        latestVersion: latestVersion,
        updateAvailable: updateAvailable,
        downloadURL: downloadURL,
        changelog: changelog,
      );
    }
    if (event is DownloadUpdate) {
      await launch(event.downloadURl);
    }
  }
}
