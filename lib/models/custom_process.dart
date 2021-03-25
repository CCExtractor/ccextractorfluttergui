import 'dart:async';
import 'dart:convert';

import 'dart:io';

/// Class which exposes a start command method to start process and stdErr, stdOut streams.
class CustomProcess {
  late Process _process;
  Future startprocess() async {
    print("started");
    _process = await Process.start(
      './assets/ccextractor',
      ['./assets/small.mpg', '--gui_mode_reports'],
    );
  }

  /// Emits a new value from stderr everytime it updates.
  Stream processStdError() {
    return _process.stderr.transform(utf8.decoder);
  }

  Stream processStdOut() {
    return _process.stdout.transform(utf8.decoder);
  }
}
