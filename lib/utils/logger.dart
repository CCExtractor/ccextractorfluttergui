import 'package:logger/logger.dart';

/// Application-wide logger instance.
///
/// Usage:
/// ```dart
/// import 'package:ccxgui/utils/logger.dart';
///
/// logger.d('Debug message');
/// logger.i('Info message');
/// logger.w('Warning message');
/// logger.e('Error message', error: exception, stackTrace: stackTrace);
/// ```
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
  level: Level.debug,
);
