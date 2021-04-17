import 'dart:convert';
import 'dart:io';

import 'package:ccxgui/main.dart';
import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

class SettingsRepository {
  // final SettingsModel settingsModel;

  // SettingsRepository(this.settingsModel);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/config.json');
  }

  // Remember to check if json is valid before storage.ready.
  Future<bool> checkValidJSON() async {
    final file = await _localFile;
    try {
      final String settings = await file.readAsString();
      Map<String, dynamic> data = jsonDecode(settings);
      for (var item in settingsList) {
        if (!data.containsKey(item)) {
          print(item);
          throw Exception("setting name not found");
        }
      }
      return true;
    } catch (e) {
      print(e);
      await file.writeAsString(jsonEncode(SettingsModel()));
      return false;
    }
  }

  Future<SettingsModel> getSettings() async {
    final SettingsModel _settings = SettingsModel();
    await storage.ready;
    _settings.outputFormat = await storage.getItem("output_format");
    _settings.outputFilename = await storage.getItem("output_file_name");
    _settings.autoprogram = await storage.getItem("autoprogram");
    _settings.append = await storage.getItem("append");
    return _settings;
  }

  Future clearSettings() async {
    print("deleting");
    await storage.ready;
    await storage.clear();
  }

  Future saveDefaults(bool force) async {
    await storage.ready;
    await storage.setItem("output_format", "srt");
    await storage.setItem("output_file_name", "");
    await storage.setItem("append", false);
    await storage.setItem("autoprogram", true);
  }

  Future saveSettings(SettingsModel settingsModel) async {
    try {
      await storage.ready;
      await storage.setItem("output_format", settingsModel.outputFormat);
      await storage.setItem("output_file_name", settingsModel.outputFilename);
      await storage.setItem("append", settingsModel.append);
      await storage.setItem("autoprogram", settingsModel.autoprogram);
    } catch (e) {
      print("Error saving settings $e");
    }
  }
}
