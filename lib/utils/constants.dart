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
  'psm': {
    'auto/default': 69,
    'OSD only (0)': 0,
    'Auto + OSD (1)': 1,
    'Auto, no OSD/OCR (2)': 2,
    'Fully auto, no OSD (3)': 3,
    'Single column (4)': 4,
    'Vertical block (5)': 5,
    'Uniform block (6)': 6,
    'Single text line (7)': 7,
    'Single word (8)': 8,
    'Single word in circle (9)': 9,
    'Single character (10)': 10,
    'Sparse text (11)': 11,
    'Sparse text + OSD (12)': 12,
    'Raw line (13)': 13,
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

List<String> ocrMode = [
  'auto/default',
  'frame',
  'word',
  'letter',
];

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

/// Output field options for --output-field
List<String> outputField = [
  'auto/default',
  '1',
  '2',
  'both',
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
  'mp4',
  'm2ts',
  'mkv',
  'mxf',
];

/// Output formats
List<String> outputFormats = [
  'auto/default',
  'srt',
  'ass',
  'ssa',
  'ccd',
  'scc',
  'webvtt',
  'webvtt-full',
  'sami',
  'bin',
  'raw',
  'dvdraw',
  'mcc',
  'txt',
  'ttxt',
  'g608',
  'smptett',
  'spupng',
  'null',
  'report',
  'simple-xml',
];
