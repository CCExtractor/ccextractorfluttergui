part of 'process_bloc.dart';

abstract class ProcessEvent {
  const ProcessEvent();
}

class ProcessFilesSubmitted extends ProcessEvent {
  // One or more files? Your choice.
  final List<XFile> files;

  const ProcessFilesSubmitted(this.files);
}

class StartAllProcess extends ProcessEvent {}

/// ProcessStopped stops all the files from processing.
class StopAllProcess extends ProcessEvent {}

/// ccx runs on all the files at once
class StartProcessInSplitMode extends ProcessEvent {}

class SplitModeProcessComplete extends ProcessEvent {}

/// Removes pending file from state queue
class ProcessFileRemoved extends ProcessEvent {
  final XFile file;

  const ProcessFileRemoved(this.file);
}

/// Stops ccx on a file using .kill()
class ProcessKill extends ProcessEvent {
  final XFile file;

  const ProcessKill(this.file);
}

/// Remvoes all files from selected and stops ccx on any running file
class ProcessRemoveAll extends ProcessEvent {}

/// Used in callback when ccx emits logs to stderr
class ProcessFileExtractorOutput extends ProcessEvent {
  final String log;

  const ProcessFileExtractorOutput(this.log);
}

/// Used in callback when ccx emits video details to stderr
class ProcessFileVideoDetails extends ProcessEvent {
  final List<String> videoDetails;

  ProcessFileVideoDetails(this.videoDetails);
}

/// Used in callback when ccx emits progress details to stderr
class ProcessFileExtractorProgress extends ProcessEvent {
  final String progress;

  const ProcessFileExtractorProgress(this.progress);
}

class ProcessFileComplete extends ProcessEvent {
  final XFile file;

  const ProcessFileComplete(this.file);
}

// emits a state with exit codes to show in snackbar
class ProcessError extends ProcessEvent {
  final int exitCode;
  const ProcessError(this.exitCode);
}

// Runs tcp udp stuff in ccx
class ProcessOnNetwork extends ProcessEvent {
  final String type;
  final String location;
  final String tcppassword;
  final String tcpdesc;

  ProcessOnNetwork(
      {required this.type,
      required this.location,
      required this.tcppassword,
      required this.tcpdesc});
}

// Gets the ccextractor version using `--version`
class GetCCExtractorVersion extends ProcessEvent {}

// Resets exitcode to 0, ideally should be null but wont emit a new state then
class ResetProcessError extends ProcessEvent {}
