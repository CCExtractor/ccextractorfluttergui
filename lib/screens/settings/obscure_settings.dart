import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/screens/settings/components/current_command.dart';
import 'package:ccxgui/screens/settings/components/custom_divider.dart';
import 'package:ccxgui/screens/settings/components/custom_textfield.dart';
import 'components/custom_swtich_listTile.dart';

class ObscureSettingsScreen extends StatelessWidget {
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
          TextEditingController programNumberController =
              TextEditingController(text: state.settingsModel.program_number);
          TextEditingController tpageController =
              TextEditingController(text: state.settingsModel.tpage);
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: CurrentCommandContainer(),
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              elevation: 0,
              toolbarHeight: 120,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  CustomSwitchListTile(
                    title: 'Panasonic DMR-ES15',
                    subtitle:
                        'Use 90090 (instead of 90000) as MPEG clock frequency. (reported to be needed at least by Panasonic DMR-ES15 DVD Recorder)',
                    value: state.settingsModel.freqEs15,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                freqEs15: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Use Picorder',
                    subtitle:
                        'Use the pic_order_cnt_lsb in AVC/H.264 data streams to order the CC information. The default way is to  the PTS information. Use this switch only when needed.',
                    value: state.settingsModel.usepicorder,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                usepicorder: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'WTV convert fix',
                    subtitle:
                        "This switch works around a bug in Windows 7's built in software to convert *.wtv to *.dvr-ms. For analog NTSC recordings the CC information is marked as digital captions. Use this switch only when needed.",
                    value: state.settingsModel.wtvconvertfix,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                wtvconvertfix: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Hauppage',
                    subtitle:
                        'If the video was recorder using a Hauppauge card, it might need special processing. This parameter will force the special treatment.',
                    value: state.settingsModel.hauppauge,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                hauppauge: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomTextField(
                    title: 'Program number',
                    subtitle:
                        'In TS mode, specifically select a program to process.',
                    intOnly: true,
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              program_number: programNumberController.text,
                            ),
                          ),
                        ),
                    controller: programNumberController,
                  ),
                  CustomSwitchListTile(
                    title: 'Multiprogram',
                    subtitle:
                        'Uses multiple programs from the same input stream.',
                    value: state.settingsModel.multiprogram,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                multiprogram: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(title: 'Myth TV'),
                  CustomSwitchListTile(
                    title: 'Use Myth TV ',
                    subtitle: 'Force MythTV code branch.',
                    value: state.settingsModel.myth,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    myth: value,
                                    nomyth: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    myth: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Disable MythTV code branch.',
                    subtitle:
                        'The MythTV branch is needed for analog captures where the closed caption data is stored in the VBI, such as those with bttv cards (Hauppage 250 for example).',
                    value: state.settingsModel.nomyth,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nomyth: value,
                                    myth: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nomyth: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Chapters',
                    subtitle:
                        '(Experimental) Produces a chapter file from MP4 files.',
                    value: state.settingsModel.chapters,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                chapters: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(title: 'Teletext settings'),
                    CustomTextField(
                      title: 'Tpage',
                      subtitle:
                          'Use this page for subtitles, for example in Spain the page is always 888',
                      intOnly: true,
                      onEditingComplete: () => context.read<SettingsBloc>().add(
                            SaveSettingsEvent(
                              state.settingsModel.copyWith(
                                tpage: tpageController.text,
                              ),
                            ),
                          ),
                      controller: tpageController,
                    ),
                  CustomSwitchListTile(
                    title: 'Teletext mode',
                    subtitle:
                        'Force teletext mode even if teletext is not detected..',
                    value: state.settingsModel.teletext,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    teletext: value,
                                    noteletext: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    teletext: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Disable teletext',
                    subtitle: 'Disable teletext processing.',
                    value: state.settingsModel.noteletext,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    noteletext: value,
                                    teletext: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    noteletext: value,
                                  ),
                                ),
                              );
                    },
                  ),
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
