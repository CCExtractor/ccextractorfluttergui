// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'components/custom_divider.dart';
import 'components/custom_swtich_listTile.dart';
import 'components/custom_textfield.dart';

class InputSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsErrorState) {
          context.read<SettingsBloc>().add(CheckSettingsEvent());
          return Center(
            child: Container(
              child: Text(
                'Settings file corrupted, restoring default values. \n ${state.message}',
              ),
            ),
          );
        }
        if (state is CurrentSettingsState) {
          TextEditingController outIntervalController =
              TextEditingController(text: state.settingsModel.outInterval);
          TextEditingController streamController =
              TextEditingController(text: state.settingsModel.stream);
          TextEditingController minlevdist =
              TextEditingController(text: state.settingsModel.minlevdist);
          TextEditingController maxlevdist =
              TextEditingController(text: state.settingsModel.maxlevdist);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Input settings',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  CustomSwitchListTile(
                    title: 'Fix pts jumps',
                    subtitle:
                        'Use this parameter if you experience timeline resets/jumps in the output.',
                    value: state.settingsModel.fixptsjumps,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                fixptsjumps: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(
                    title: 'Output file segmentation',
                  ),
                  CustomTextField(
                    title: 'Number of outputs in X seconds',
                    subtitle:
                        'X output files in interval of X seconds, accepts only numerical input, press enter to save',
                    intOnly: true,
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              outInterval: outIntervalController.text,
                            ),
                          ),
                        ),
                    controller: outIntervalController,
                  ),
                  CustomSwitchListTile(
                    title: 'Segment on key only',
                    subtitle:
                        'When segmenting files, do it only after a I frame trying to behave like FFmpeg',
                    value: state.settingsModel.segmentonkeyonly,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                segmentonkeyonly: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(
                    title: 'Stream',
                  ),
                  CustomTextField(
                    title: 'Continuous stream',
                    subtitle:
                        "Consider the file as a continuous stream that is growing as ccextractor processes it\nso don't try to figure out its size and don't terminate processing when reaching the current end",
                    intOnly: true,
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              stream: streamController.text,
                            ),
                          ),
                        ),
                    controller: streamController,
                  ),
                  CustomDivider(
                    title: 'Input file processing',
                  ),
                  CustomSwitchListTile(
                    title: 'Use GOP for timing instead of PTS',
                    subtitle:
                        'This only applies to Program or Transport Streams with MPEG2 data and overrides the default PTS timing.',
                    value: state.settingsModel.goptime,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    goptime: value,
                                    nogoptime: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    goptime: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Never use GOP timing (use PTS)',
                    subtitle:
                        'Use PTS even if ccextractor detects GOP timing is the reasonable choice',
                    value: state.settingsModel.nogoptime,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nogoptime: value,
                                    goptime: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nogoptime: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Fix padding',
                    subtitle:
                        'Some cards (or providers, or whatever) seem to send 0000 as CC padding instead of 8080. If you get bad timing, this might solve it',
                    value: state.settingsModel.fixpadding,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                fixpadding: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: "Video edited, don't rebuild original timing",
                    subtitle:
                        "If you are processing video hat was split with a editing tool, use this so ccextractor doesn't try to rebuild the original timing.",
                    value: state.settingsModel.videoedited,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                videoedited: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Fix padding',
                    subtitle:
                        'Some cards (or providers, or whatever) seem to send 0000 as CC padding instead of 8080. If you get bad timing, this might solve it',
                    value: state.settingsModel.fixpadding,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                fixpadding: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Use MPEG2 stream',
                    subtitle:
                        'Read the captions from the MPEG2 video stream rather than the captions stream in WTV files',
                    value: state.settingsModel.wtvmpeg2,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                wtvmpeg2: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'MP4 Video track',
                    subtitle:
                        'In MP4 files the closed caption data can be embedded in the video track or in a dedicated CC track. If a dedicated track is detected it will be processed instead of the video track. If you need to force the video track to be processed instead use this option.',
                    value: state.settingsModel.mp4vidtrack,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                mp4vidtrack: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'No auto time ref',
                    subtitle:
                        'Some streams come with broadcast date information. When such data is available, CCExtractor will set its time  reference to the received data. Use this parameter if  prefer your own reference. Note: Current this only affects Teletext in timed transcript with -datets.',
                    value: state.settingsModel.noautotimeref,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                noautotimeref: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'No SCTE-20',
                    subtitle: 'Ignore SCTE-20 data if present.',
                    value: state.settingsModel.noscte20,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                noscte20: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'WebVTT CSS',
                    subtitle:
                        'Create a separate file for CSS instead of inline.',
                    value: state.settingsModel.webvttcss,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                webvttcss: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(title: 'Levenshtein distance'),
                  CustomSwitchListTile(
                    title: 'No Levenshtein distance',
                    subtitle:
                        "Don't attempt to correct typos with Levenshtein distance.",
                    value: state.settingsModel.nolevdist,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                nolevdist: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomTextField(
                    title: 'Minumin Levenshtein distance count',
                    intOnly: true,
                    subtitle:
                        'Minimum distance we always allow regardless of the length of the strings.Default 2.',
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              minlevdist: minlevdist.text,
                            ),
                          ),
                        ),
                    controller: minlevdist,
                  ),
                  CustomTextField(
                    title: 'Maximun eLvenshtein distance percentage',
                    intOnly: true,
                    subtitle:
                        'Maximum distance we allow, as a percentage of the shortest string length. Default 10%.',
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              maxlevdist: maxlevdist.text,
                            ),
                          ),
                        ),
                    controller: maxlevdist,
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
