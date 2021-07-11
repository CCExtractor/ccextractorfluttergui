import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/utils/constants.dart';

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
      // This checks if the file is in a valid json format
      Map<String, dynamic> data = jsonDecode(settings);
      for (var item in SettingsModel().toJson().keys) {
        // This checks if all the keys from settings mode (put in a seperate list in contants file), exists or not.
        // If not, exception is thrown and default settings are written.
        if (!data.containsKey(item)) {
          throw Exception('Setting key not found');
        }
      }
      // This checks if all the values are of the intended datatype. TODO
      if (outputFormats.contains(data['out']) &&
          data['outputfilename'] is String &&
          data['append'] is bool &&
          data['autoprogram'] is bool) {
      } else {
        throw Exception('Settings value has mismatched datatype');
      }
      return true;
    } catch (e) {
      print('Rewriting config.json file');
      await file.writeAsString(jsonEncode(SettingsModel()));
      return false;
    }
  }

  List<String> getParamsList(SettingsModel settings, {String filePath = ''}) {
    List<String> paramsList = [];
    paramsList.addAll(
      settings.enabledSettings.map((param) => '--' + param).toList(),
    );
    settings.enabledtextfields.forEach((param) {
      if (param.keys.first != 'encoder') {
        // no --encoder direct -latin1 or -utf8
        paramsList.add('  --' + param.keys.first);
      }
      if (param.keys.first == 'outputfilename' && filePath.isNotEmpty) {
        paramsList.add(
            '${filePath.substring(0, filePath.lastIndexOf(RegExp(r'(\\|\/)')))}/${param.values.first}');
      } else if (param.keys.first == 'encoder') {
        paramsList.add('--' + param.values.first);
      } else {
        paramsList.add(param.values.first);
      }
    });
    // print(paramsList); [--autoprogram, --outputfilename, ewf, --defaultcolor, #FFFFFF, --delay, 22]
    return paramsList;
  }

  Future<SettingsModel> getSettings() async {
    SettingsModel _settings = SettingsModel();
    try {
      LocalStorage storage = LocalStorage('config.json');
      await storage.ready;
      _settings = SettingsModel.fromJson(storage.getData());
    } catch (e) {
      print('GetSettings Error $e');
    }
    return _settings;
  }

  Future clearSettings() async {
    print('deleting');
    LocalStorage storage = LocalStorage('config.json');
    await storage.ready;
    await storage.clear();
  }

  Future saveSettings(SettingsModel settingsModel) async {
    try {
      LocalStorage storage = LocalStorage('config.json');
      await storage.ready;
      await storage.setData(settingsModel.toJson());
    } catch (e) {
      print('Error saving settings $e');
    }
  }
}
