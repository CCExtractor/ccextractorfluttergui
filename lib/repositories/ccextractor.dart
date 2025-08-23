import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';

import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/repositories/settings_repository.dart';

class CCExtractor {
  late Process process;
  final RegExp progressRegx = RegExp(r'###PROGRESS#(\d+)', multiLine: true);
  final RegExp summaryRegx = RegExp(r'\[(.*?)\]', multiLine: true);
  final RegExp logsRegx =
      RegExp(r'###SUBTITLE###(.+)|###TIME###(.+)', multiLine: true);
  final RegExp videoDetailsRegx = RegExp(r'###VIDEOINFO#(.+)', multiLine: true);

  SettingsRepository settingsRepository = SettingsRepository();
  SettingsModel settings = SettingsModel();
  String get ccextractor {
    return Platform.isWindows ? './ccextractorwinfull.exe' : './ccextractor';
  }

  Future<int> extractFile(
    XFile file, {
    required Function(String) listenProgress,
    required Function(String) listenOutput,
    required Function(List<String>) listenVideoDetails,
  }) async {
    settings = await settingsRepository.getSettings();
    List<String> paramsList =
        settingsRepository.getParamsList(settings, filePath: file.path);
    process = await Process.start(
      ccextractor,
      [
        file.path,
        '--gui_mode_reports',
        ...paramsList,
      ],
    );
    // sometimes stdout and stderr have important logs like how much time
    // it took to process the file or some erros not captured by exitcodes,
    // so just print them to the logs box
    process.stdout.transform(latin1.decoder).listen((update) {
      // print(update);
      listenOutput(update);
    });

    process.stderr.transform(latin1.decoder).listen((update) {
      // print(update);
      if (progressRegx.hasMatch(update)) {
        for (RegExpMatch i in progressRegx.allMatches(update)) {
          listenProgress(i[1]!);
        }
      }
      if (logsRegx.hasMatch(update)) {
        for (RegExpMatch i in logsRegx.allMatches(update)) {
          // 1,2 are here for regex groups, 1 corresponds to subtitle regex
          // match and 2 is time regex match. Later we can seperate this if
          // needed (no additonal benefit rn imo;td)
          if (i[1] != null) listenOutput(i[1]!);
          if (i[2] != null) listenOutput(i[2]!);
        }
      }
      if (videoDetailsRegx.hasMatch(update)) {
        for (RegExpMatch i in videoDetailsRegx.allMatches(update)) {
          listenVideoDetails(i[1]!.split('#'));
        }
      }
      update.contains('Error') ? listenOutput(update) : null;
    });
    return process.exitCode;
  }

  Future<int> extractFileOverNetwork({
    required String type,
    required String location,
    required String tcppasswrd,
    required String tcpdesc,
    required Function(String) listenProgress,
    required Function(String) listenOutput,
    required Function(List<String>) listenVideoDetails,
  }) async {
    settings = await settingsRepository.getSettings();
    List<String> paramsList = settingsRepository.getParamsList(settings);
    process = await Process.start(
      ccextractor,
      [
        '-' + type,
        location,
        tcppasswrd.isNotEmpty ? '-tcppasswrd' + tcppasswrd : '',
        tcpdesc.isNotEmpty ? '-tcpdesc' + tcpdesc : '',
        '--gui_mode_reports',
        ...paramsList,
      ],
    );

    process.stdout.transform(latin1.decoder).listen((update) {
      // print(update);
      listenOutput(update);
    });

    process.stderr.transform(latin1.decoder).listen((update) {
      if (progressRegx.hasMatch(update)) {
        for (RegExpMatch i in progressRegx.allMatches(update)) {
          listenProgress(i[1]!);
        }
      }
      if (logsRegx.hasMatch(update)) {
        for (RegExpMatch i in logsRegx.allMatches(update)) {
          // 1,2 are here for regex groups, 1 corresponds to subtitle regex
          // match and 2 is time regex match. Later we can seperate this if
          // needed (no additonal benefit rn imo;td)
          if (i[1] != null) listenOutput(i[1]!);
          if (i[2] != null) listenOutput(i[2]!);
        }
      }
      if (videoDetailsRegx.hasMatch(update)) {
        for (RegExpMatch i in videoDetailsRegx.allMatches(update)) {
          listenVideoDetails(i[1]!.split('#'));
        }
      }
      update.contains('Error') ? listenOutput(update) : null;
    });
    return process.exitCode;
  }

  // List<String> allFilesPath(List<XFile> files) {
  //   tempList = [];

  // }

  Future<int> extractFilesInSplitMode(
    List<XFile> files, {
    required Function(String) listenProgress,
    required Function(String) listenOutput,
    required Function(List<String>) listenVideoDetails,
  }) async {
    settings = await settingsRepository.getSettings();
    List<String> paramsList = settingsRepository.getParamsList(settings);
    process = await Process.start(
      ccextractor,
      [
        ...files.map((e) => e.path).toList(),
        '--gui_mode_reports',
        ...paramsList,
      ],
    );
    // sometimes stdout and stderr have important logs like how much time
    // it took to process the file or some erros not captured by exitcodes,
    // so just print them to the logs box
    process.stdout.transform(latin1.decoder).listen((update) {
      // print(update);
      listenOutput(update);
    });

    process.stderr.transform(latin1.decoder).listen((update) {
      // print(update);
      if (progressRegx.hasMatch(update)) {
        for (RegExpMatch i in progressRegx.allMatches(update)) {
          listenProgress(i[1]!);
        }
      }
      if (logsRegx.hasMatch(update)) {
        for (RegExpMatch i in logsRegx.allMatches(update)) {
          // 1,2 are here for regex groups, 1 corresponds to subtitle regex
          // match and 2 is time regex match. Later we can seperate this if
          // needed (no additonal benefit rn imo;td)
          if (i[1] != null) listenOutput(i[1]!);
          if (i[2] != null) listenOutput(i[2]!);
        }
      }
      if (videoDetailsRegx.hasMatch(update)) {
        for (RegExpMatch i in videoDetailsRegx.allMatches(update)) {
          listenVideoDetails(i[1]!.split('#'));
        }
      }
      update.contains('Error') ? listenOutput(update) : null;
    });
    return process.exitCode;
  }

  /// Cancels the ongoing file process
  void cancelRun() {
    process.kill();
  }

  Future<String> get getCCExtractorVersion async {
    String ccxStdOut = '0';
    await Process.run(ccextractor, ['--version']).then((value) {
      ccxStdOut = value.stdout
          .toString()
          .substring(value.stdout.toString().indexOf('Version:') + 8,
              value.stdout.toString().indexOf('Version:') + 15)
          .trim();
    });
    return ccxStdOut;
  }

  static Map<int, String> exitCodes = {
    0: 'EXIT_OK',
    2: 'EXIT_NO_INPUT_FILES',
    3: 'EXIT_TOO_MANY_INPUT_FILES',
    4: 'EXIT_INCOMPATIBLE_PARAMETERS',
    6: 'EXIT_UNABLE_TO_DETERMINE_FILE_SIZE',
    7: 'EXIT_MALFORMED_PARAMETER',
    8: 'EXIT_READ_ERROR',
    10: 'EXIT_NO_CAPTIONS',
    300: 'EXIT_NOT_CLASSIFIED',
    501: 'EXIT_ERROR_IN_CAPITALIZATION_FILE',
    502: 'EXIT_BUFFER_FULL',
    1001: 'EXIT_MISSING_ASF_HEADER',
    1002: 'EXIT_MISSING_RCWT_HEADER',
    5: 'CCX_COMMON_EXIT_FILE_CREATION_FAILED',
    9: 'CCX_COMMON_EXIT_UNSUPPORTED',
    500: 'EXIT_NOT_ENOUGH_MEMORY',
    1000: 'CCX_COMMON_EXIT_BUG_BUG',
  };
}
