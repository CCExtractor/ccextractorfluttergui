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
      http.Response response = await http.get(url, headers: {
        'Authorization': String.fromEnvironment('TOKEN'),
      });
      var data = jsonDecode(response.body);
      String latestVersion = data[0]['tag_name'].toString().substring(1);
      String downloadURL =
          data[0]['assets'][0]['browser_download_url'].toString();
      String changelog = data[0]['body'].toString();
      bool updateAvailable =
          double.parse(latestVersion) > double.parse(event.currentVersion);
      print(latestVersion);
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
