class Video {
  /// Print other useful stuff from stfouf
  // final String streamMode;
  // final String program;
  // final String hauPageMode;
  // final String mythTvCode;
  // final String timingMode;
  // final String debug;
  // final String bufferInput;
  final String encoding;
  final String targetFormat;
  final String resolution;
  final String aspectRatio;
  final String frameRate;

  Video(this.resolution, this.aspectRatio, this.frameRate, this.encoding, this.targetFormat);
}
