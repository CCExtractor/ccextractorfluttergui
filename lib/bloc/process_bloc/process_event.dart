part of 'process_bloc.dart';

abstract class ProcessEvent {
  const ProcessEvent();
}

class ProcessFilesSubmitted extends ProcessEvent {
  // One or more files? Your choice.
  final List<XFile> files;

  const ProcessFilesSubmitted(this.files);
}

class ProcessStarted extends ProcessEvent {}

/// ProcessStopped stops all the files from processing after finishing the
/// current one. Maybe use process.kill for this?
class ProcessStopped extends ProcessEvent {}

class ProcessFileRemoved extends ProcessEvent {
  final XFile file;

  const ProcessFileRemoved(this.file);
}

class ProcessKill extends ProcessEvent {
  final XFile file;

  const ProcessKill(this.file);
}

class ProcessRemoveAll extends ProcessEvent {}

class ProcessFileExtractorOutput extends ProcessEvent {
  final String log;

  const ProcessFileExtractorOutput(this.log);
}

class ProcessFileVideoDetails extends ProcessEvent {
  final List<String> videoDetails;

  ProcessFileVideoDetails(this.videoDetails);
}

class ProcessFileExtractorProgress extends ProcessEvent {
  final String progress;

  const ProcessFileExtractorProgress(this.progress);
}

class ProcessFileComplete extends ProcessEvent {
  final XFile file;

  const ProcessFileComplete(this.file);
}

class ProcessError extends ProcessEvent {
  final int exitCode;
  const ProcessError(this.exitCode);
}

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

class GetCCExtractorVersion extends ProcessEvent {}
