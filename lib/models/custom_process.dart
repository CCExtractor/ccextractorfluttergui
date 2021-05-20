import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:localstorage/localstorage.dart';

/// Class which exposes a start command method to start process and stdErr, stdOut streams.
class CustomProcess {
  late Process _process;
  final String filePath;
  late String outputFileName;
  late String outputFormat;
  LocalStorage storage = LocalStorage('config.json');

  CustomProcess(this.filePath);
  Future getData() async {
    await storage.ready;
    outputFileName = await storage.getItem('output_file_name');
    outputFormat = await storage.getItem('output_format');
  }

  Future startprocess() async {
    await getData();
    _process = await Process.start(
      './assets/ccextractor',
      [
        filePath,
        '--gui_mode_reports',
        '-latin1',
        '-o',
        '${filePath.substring(0, filePath.lastIndexOf('/'))}/$outputFileName.$outputFormat',
        '-out=$outputFormat'
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
