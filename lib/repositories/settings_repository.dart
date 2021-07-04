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
        paramsList.add('--' + param.keys.first);
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
    final SettingsModel _settings = SettingsModel();
    try {
      LocalStorage storage = LocalStorage('config.json');
      await storage.ready;
      _settings.out = await storage.getItem('out');
      _settings.inp = await storage.getItem('inp');
      _settings.outputfilename = await storage.getItem('outputfilename');
      _settings.fixptsjumps = await storage.getItem('fixptsjumps');
      _settings.outInterval = await storage.getItem('outInterval');
      _settings.segmentonkeyonly = await storage.getItem('segmentonkeyonly');
      _settings.append = await storage.getItem('append');
      _settings.goptime = await storage.getItem('goptime');
      _settings.nogoptime = await storage.getItem('nogoptime');
      _settings.fixpadding = await storage.getItem('fixpadding');
      _settings.freqEs15 = await storage.getItem('freqEs15');
      _settings.stream = await storage.getItem('stream');
      _settings.videoedited = await storage.getItem('videoedited');
      _settings.usepicorder = await storage.getItem('usepicorder');
      _settings.myth = await storage.getItem('myth');
      _settings.nomyth = await storage.getItem('nomyth');
      _settings.wtvconvertfix = await storage.getItem('wtvconvertfix');
      _settings.wtvmpeg2 = await storage.getItem('wtvmpeg2');
      _settings.program_number = await storage.getItem('program_number');
      _settings.autoprogram = await storage.getItem('autoprogram');
      _settings.multiprogram = await storage.getItem('multiprogram');
      _settings.datapid = await storage.getItem('datapid');
      _settings.hauppauge = await storage.getItem('hauppauge');
      _settings.mp4vidtrack = await storage.getItem('mp4vidtrack');
      _settings.noautotimeref = await storage.getItem('noautotimeref');
      _settings.noscte20 = await storage.getItem('noscte20');
      _settings.webvttcss = await storage.getItem('webvttcss');
      _settings.analyzevideo = await storage.getItem('analyzevideo');
      _settings.notimestamp = await storage.getItem('notimestamp');
      _settings.nolevdist = await storage.getItem('nolevdist');
      _settings.minlevdist = await storage.getItem('minlevdist');
      _settings.maxlevdist = await storage.getItem('maxlevdist');
      _settings.chapters = await storage.getItem('chapters');
      _settings.bom = await storage.getItem('bom');
      _settings.nobom = await storage.getItem('nobom');
      _settings.encoder = await storage.getItem('encoder');
      _settings.nofontcolor = await storage.getItem('nofontcolor');
      _settings.nohtmlescape = await storage.getItem('nohtmlescape');
      _settings.notypesetting = await storage.getItem('notypesetting');
      _settings.trim = await storage.getItem('trim');
      _settings.defaultcolor = await storage.getItem('defaultcolor');
      _settings.sentencecap = await storage.getItem('sentencecap');
      _settings.kf = await storage.getItem('kf');
      _settings.splitbysentence = await storage.getItem('splitbysentence');
      _settings.datets = await storage.getItem('datets');
      _settings.sects = await storage.getItem('sects');
      _settings.latrusmap = await storage.getItem('latrusmap');
      _settings.xds = await storage.getItem('xds');
      _settings.lf = await storage.getItem('lf');
      _settings.df = await storage.getItem('df');
      _settings.autodash = await storage.getItem('autodash');
      _settings.xmltv = await storage.getItem('xmltv');
      _settings.xmltvliveinterval = await storage.getItem('xmltvliveinterval');
      _settings.xmltvoutputinterval =
          await storage.getItem('xmltvoutputinterval');
      _settings.xmltvonlycurrent = await storage.getItem('xmltvonlycurrent');
      _settings.sem = await storage.getItem('sem');
      _settings.quantmode = await storage.getItem('quantmode');
      _settings.oem = await storage.getItem('oem');
      _settings.bufferinput = await storage.getItem('bufferinput');
      _settings.nobufferinput = await storage.getItem('nobufferinput');
      _settings.buffersize = await storage.getItem('buffersize');
      _settings.koc = await storage.getItem('koc');
      _settings.dru = await storage.getItem('dru');
      _settings.norollup = await storage.getItem('norollup');
      _settings.delay = await storage.getItem('delay');
      _settings.startat = await storage.getItem('startat');
      _settings.endat = await storage.getItem('endat');
      _settings.tpage = await storage.getItem('tpage');
      _settings.teletext = await storage.getItem('teletext');
      _settings.noteletext = await storage.getItem('noteletext');
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
      await storage.setItem('out', settingsModel.out);
      await storage.setItem('inp', settingsModel.inp);
      await storage.setItem('outputfilename', settingsModel.outputfilename);
      await storage.setItem('fixptsjumps', settingsModel.fixptsjumps);
      await storage.setItem('outInterval', settingsModel.outInterval);
      await storage.setItem('segmentonkeyonly', settingsModel.segmentonkeyonly);
      await storage.setItem('append', settingsModel.append);
      await storage.setItem('goptime', settingsModel.goptime);
      await storage.setItem('nogoptime', settingsModel.nogoptime);
      await storage.setItem('fixpadding', settingsModel.fixpadding);
      await storage.setItem('freqEs15', settingsModel.freqEs15);
      await storage.setItem('stream', settingsModel.stream);
      await storage.setItem('videoedited', settingsModel.videoedited);
      await storage.setItem('usepicorder', settingsModel.usepicorder);
      await storage.setItem('myth', settingsModel.myth);
      await storage.setItem('nomyth', settingsModel.nomyth);
      await storage.setItem('wtvconvertfix', settingsModel.wtvconvertfix);
      await storage.setItem('wtvmpeg2', settingsModel.wtvmpeg2);
      await storage.setItem('program_number', settingsModel.program_number);
      await storage.setItem('autoprogram', settingsModel.autoprogram);
      await storage.setItem('multiprogram', settingsModel.multiprogram);
      await storage.setItem('datapid', settingsModel.datapid);
      await storage.setItem('hauppauge', settingsModel.hauppauge);
      await storage.setItem('mp4vidtrack', settingsModel.mp4vidtrack);
      await storage.setItem('noautotimeref', settingsModel.noautotimeref);
      await storage.setItem('noscte20', settingsModel.noscte20);
      await storage.setItem('webvttcss', settingsModel.webvttcss);
      await storage.setItem('analyzevideo', settingsModel.analyzevideo);
      await storage.setItem('notimestamp', settingsModel.notimestamp);
      await storage.setItem('nolevdist', settingsModel.nolevdist);
      await storage.setItem('minlevdist', settingsModel.minlevdist);
      await storage.setItem('maxlevdist', settingsModel.maxlevdist);
      await storage.setItem('chapters', settingsModel.chapters);
      await storage.setItem('bom', settingsModel.bom);
      await storage.setItem('nobom', settingsModel.nobom);
      await storage.setItem('encoder', settingsModel.encoder);
      await storage.setItem('nofontcolor', settingsModel.nofontcolor);
      await storage.setItem('nohtmlescape', settingsModel.nohtmlescape);
      await storage.setItem('notypesetting', settingsModel.notypesetting);
      await storage.setItem('trim', settingsModel.trim);
      await storage.setItem('defaultcolor', settingsModel.defaultcolor);
      await storage.setItem('sentencecap', settingsModel.sentencecap);
      await storage.setItem('kf', settingsModel.kf);
      await storage.setItem('splitbysentence', settingsModel.splitbysentence);
      await storage.setItem('datets', settingsModel.datets);
      await storage.setItem('sects', settingsModel.sects);
      await storage.setItem('latrusmap', settingsModel.latrusmap);
      await storage.setItem('xds', settingsModel.xds);
      await storage.setItem('lf', settingsModel.lf);
      await storage.setItem('df', settingsModel.df);
      await storage.setItem('autodash', settingsModel.autodash);
      await storage.setItem('xmltv', settingsModel.xmltv);
      await storage.setItem(
          'xmltvliveinterval', settingsModel.xmltvliveinterval);
      await storage.setItem(
          'xmltvoutputinterval', settingsModel.xmltvoutputinterval);
      await storage.setItem('xmltvonlycurrent', settingsModel.xmltvonlycurrent);
      await storage.setItem('sem', settingsModel.sem);
      await storage.setItem('quantmode', settingsModel.quantmode);
      await storage.setItem('oem', settingsModel.oem);
      await storage.setItem('bufferinput', settingsModel.bufferinput);
      await storage.setItem('nobufferinput', settingsModel.nobufferinput);
      await storage.setItem('buffersize', settingsModel.buffersize);
      await storage.setItem('koc', settingsModel.koc);
      await storage.setItem('dru', settingsModel.dru);
      await storage.setItem('norollup', settingsModel.norollup);
      await storage.setItem('delay', settingsModel.delay);
      await storage.setItem('startat', settingsModel.startat);
      await storage.setItem('endat', settingsModel.endat);
      await storage.setItem('tpage', settingsModel.tpage);
      await storage.setItem('teletext', settingsModel.teletext);
      await storage.setItem('noteletext', settingsModel.noteletext);
    } catch (e) {
      print('Error saving settings $e');
    }
  }
}
