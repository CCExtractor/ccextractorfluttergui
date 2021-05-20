import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';

class CCExtractor {
  late Process process;
  final RegExp progressRegx = RegExp(r'###PROGRESS#(\d+)', multiLine: true);
  final RegExp summaryRegx = RegExp(r'\[(.*?)\]', multiLine: true);
  final RegExp logsRegx =
      RegExp(r'###SUBTITLE###(.+)|###TIME###(.+)', multiLine: true);
  Future<int> extractFile(
    XFile file, {
    required Function(String) listenProgress,
    required Function(String) listenOutput,
  }) async {
    //TODO: pass settings and stuff in here.
    process = await Process.start('./assets/ccextractor', [
      file.path,
      '--gui_mode_reports',
      '-latin1',
    ]);
    process.stderr.transform(latin1.decoder).listen((update) {
      if (progressRegx.hasMatch(update)) {
        for (RegExpMatch i in progressRegx.allMatches(update)) {
          listenProgress(i[1]!);
        }
      }
      if (logsRegx.hasMatch(update)) {
        for (RegExpMatch i in logsRegx.allMatches(update)) {
          // Not sure what this 1,2 was, probably something related to regex
          // groups, will check while testing. TODO
          if (i[1] != null) listenOutput(i[1]!);
          if (i[2] != null) listenOutput(i[2]!);
        }
      }
    });
    return process.exitCode;
  }
}
