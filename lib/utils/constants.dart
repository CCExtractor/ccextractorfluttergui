import 'package:flutter/material.dart';

const kBgLightColor = Color(0xFF303030);
const kBgDarkColor = Color(0xFF181818);
const kDefaultPadding = 20.0;

Map<String, Map<String, int>> dropdownListMap = {
  'xmltv': {
    'auto/default': 69, // this wont happen so any random value for now.
    'Full output': 1,
    'Live output': 2,
    'Both': 3,
  },
  'quant': {
    'auto/default': 69,
    'Don\'t quantize at all.': 0,
    'Use CCExtractor\'s internal function (default).': 1,
    'Reduce distinct color count in image for faster results.': 2,
  },
  'oem': {
    'auto/default': 69,
    'OEM_TESSERACT_ONLY - the fastest mode.': 0,
    'OEM_LSTM_ONLY - use LSTM algorithm for recognition.': 1,
    'OEM_TESSERACT_LSTM_COMBINED - both algorithms.': 2,
  },
};

List<String> encoder = [
  'auto/default',
  'utf8',
  'unicode',
  'latin1',
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
