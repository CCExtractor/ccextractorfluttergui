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
  'streamtype': {
    'auto/default': 69,
    'VIDEO_MPEG1': 1,
    'VIDEO_MPEG2': 2,
    'AUDIO_MPEG1': 3,
    'AUDIO_MPEG2': 4,
    'PRIVATE_TABLE_MPEG2': 5,
    'PRIVATE_MPEG2': 6,
    'MHEG_PACKETS': 7,
    'MPEG2_ANNEX_A_DSM_CC': 8,
    'ITU_T_H222_1': 9,
    'ISO_IEC_13818_6_TYPE_A': 10,
    'ISO_IEC_13818_6_TYPE_B': 11,
    'ISO_IEC_13818_6_TYPE_C': 12,
    'ISO_IEC_13818_6_TYPE_D': 13,
    'AUDIO_AAC': 15,
    'VIDEO_MPEG4': 16,
    'VIDEO_H264': 27,
    'PRIVATE_USER_MPEG2': 128,
    'AUDIO_AC3': 129,
    'AUDIO_HDMV_DTS': 130,
    'AUDIO_DTS': 138
  },
};
List<String> rollUp = [
  'auto/default',
  'ru1',
  'ru2',
  'ru3',
];

//codec and nocodec have the same options
List<String> codec = [
  'auto/default',
  'dvbsub',
  'teletext',
];

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
