import 'package:flutter/material.dart';

const kBgLightColor = Color(0xFF303030);
const kBgDarkColor = Color(0xFF181818);
const kDefaultPadding = 20.0;

List<String> encoder = [
  'auto/default',
  'utf8',
  'unicode',
  'latin1',
];

List<String> xmltv = [
  'auto/default',
  'Full output',
  'Live output',
  'Both',
];

/// Input formats
List<String> inputFormats = [
  'auto/default',
  'ts',
  'ps',
  'es',
  'asf',
  'wtv',
  'bin',
  'raw',
  'mp4'
];

List<String> quantMode = [
  'auto/default',
  'Don\'t quantize at all.',
  'Use CCExtractor\'s internal function (default).',
  'Reduce distinct color count in image for faster results.',
];

List<String> oem = [
  'auto/default',
  'OEM_TESSERACT_ONLY - the fastest mode.',
  'OEM_LSTM_ONLY - use LSTM algorithm for recognition.',
  'OEM_TESSERACT_LSTM_COMBINED - both algorithms.',
];

/// Output formats
List<String> outputFormats = [
  'auto/default',
  'srt',
  'ssa',
  'webvtt',
  'sami',
  'bin',
  'raw',
  'dvdraw',
  'txt',
  'ttxt',
  'smptett',
  'spupng',
  'null',
];
