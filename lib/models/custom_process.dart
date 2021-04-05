import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:hive/hive.dart';

/// Class which exposes a start command method to start process and stdErr, stdOut streams.
class CustomProcess {
  late Process _process;
  final String filePath;
  late String outputFileName;
  var settingsBox = Hive.box("settingsBox");
  CustomProcess(this.filePath);
  Future startprocess() async {
    outputFileName = settingsBox.get("output_file_name");

    print("started");
    _process = await Process.start(
      './assets/ccextractor',
      [
        filePath,
        '--gui_mode_reports',
        '-latin1',
        '-o',
        '${filePath.substring(0, filePath.lastIndexOf("/"))}/$outputFileName.${settingsBox.get("output_format")}',
        '-out=${settingsBox.get("output_format")}'
      ],
    );
  }

  /// Emits a new value from stderr everytime it updates.
  Stream processStdError() {
    return _process.stderr.transform(latin1.decoder);
  }

  Stream processStdOut() {
    return _process.stdout.transform(latin1.decoder);
  }
}
