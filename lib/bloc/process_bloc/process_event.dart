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

class ProcessStopped extends ProcessEvent {}

class ProcessFileRemoved extends ProcessEvent {
  final XFile file;

  const ProcessFileRemoved(this.file);
}

class ProcessFileExtractorOutput extends ProcessEvent {
  final String log;

  const ProcessFileExtractorOutput(this.log);
}

class ProcessFileExtractorProgress extends ProcessEvent {
  final String progress;

  const ProcessFileExtractorProgress(this.progress);
}

class ProcessFileComplete extends ProcessEvent {
  final XFile file;

  const ProcessFileComplete(this.file);
}
