import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/screens/settings/components/current_command.dart';
import 'package:ccxgui/utils/constants.dart';
import 'components/custom_divider.dart';
import 'components/custom_dropdown.dart';
import 'components/custom_swtich_listTile.dart';
import 'components/custom_textfield.dart';

class BasicSettingsScreen extends StatelessWidget {
  final ScrollController controller = ScrollController();
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
          TextEditingController outputFileNameController =
              TextEditingController(text: state.settingsModel.outputfilename);
          TextEditingController delay =
              TextEditingController(text: state.settingsModel.delay);
          TextEditingController startat =
              TextEditingController(text: state.settingsModel.startat);
          TextEditingController endat =
              TextEditingController(text: state.settingsModel.endat);

          return Scaffold(
            appBar: AppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: CurrentCommandContainer(),
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              elevation: 0,
              toolbarHeight: 110,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scrollbar(
                controller: controller,
                child: ListView(
                  controller: controller,
                  children: [
                  CustomTextField(
                    title: 'Output file name (press enter to save)',
                    subtitle:
                        "This will define the output filename if you don't like the default ones. Each file will be appeded with a _1, _2 when needed",
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              outputfilename: outputFileNameController.text,
                            ),
                          ),
                        ),
                    controller: outputFileNameController,
                  ),
                  CustomDropDown(
                    title: 'Input file format',
                    subtitle:
                        'Force the file with a specific input format, leave blank to auto-detect',
                    value: state.settingsModel.inp,
                    items: inputFormats,
                    onChanged: (String newValue) =>
                        context.read<SettingsBloc>().add(
                              SettingsUpdatedEvent(
                                state.settingsModel.copyWith(
                                  inp: newValue,
                                ),
                              ),
                            ),
                  ),
                  CustomDropDown(
                    title: 'Output file format',
                    subtitle:
                        'This will generate the output in the selected format.',
                    value: state.settingsModel.out,
                    items: outputFormats,
                    onChanged: (String newValue) =>
                        context.read<SettingsBloc>().add(
                              SettingsUpdatedEvent(
                                state.settingsModel.copyWith(
                                  out: newValue,
                                ),
                              ),
                            ),
                  ),
                  CustomSwitchListTile(
                    title: 'Append',
                    subtitle:
                        'This will prevent overwriting of existing files. The output will be appended instead.',
                    value: state.settingsModel.append,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                append: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Autoprogram',
                    subtitle:
                        "If there's more than one program in the stream, this will the first one we find that contains a suitable stream.",
                    value: state.settingsModel.autoprogram,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                autoprogram: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Enable split mode',
                    subtitle:
                        'Output will be one single file (either raw or srt). Use this if you made your recording in several cuts (to skip commercials for example) but you want one subtitle file with continuous timing. (warning: you cannot add more files till ccextractor finishes running on the selected files when this is enabled',
                    value: state.settingsModel.splitMode,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                splitMode: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(title: 'Timing settings'),
                  CustomTextField(
                    title: 'Delay (ms)',
                    intOnly: true,
                    subtitle:
                        'For srt/sami/webvtt, add this number of milliseconds to all times.You can also use negative numbers to make subs appear early.',
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              delay: delay.text,
                            ),
                          ),
                        ),
                    controller: delay,
                  ),
                  CustomTextField(
                    title: 'Start at',
                    subtitle:
                        'Only write caption information that starts after the given time. Format: S or  MM:SS',
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(startat.text) ||
                              startat.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    startat: startat.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: startat,
                  ),
                  CustomTextField(
                    title: 'End at',
                    subtitle:
                        'Stop processing after the given time (same format as start at).',
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(endat.text) ||
                              endat.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    endat: endat.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: endat,
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
