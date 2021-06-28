// Flutter imports:
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/utils/constants.dart';
import 'components/custom_divider.dart';
import 'components/custom_dropdown.dart';
import 'components/custom_swtich_listTile.dart';
import 'components/custom_textfield.dart';

class OutputSettingsScreen extends StatelessWidget {
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
          TextEditingController defaultColorController =
              TextEditingController(text: state.settingsModel.defaultcolor);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Output settings',
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
                    title: 'BOM',
                    subtitle:
                        'Append a BOM (Byte Order Mark) to output files. This is the default in Windows builds.',
                    value: state.settingsModel.bom,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    bom: value,
                                    nobom: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    bom: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'No BOM',
                    subtitle:
                        'Do not append a BOM (Byte Order Mark) to output files. Note that this may break files when using Windows.',
                    value: state.settingsModel.nobom,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nobom: value,
                                    bom: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nobom: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomDropDown(
                    title: 'Encoder',
                    subtitle: 'Encode subtitles in the selected format',
                    value: state.settingsModel.encoder,
                    items: encoder,
                    onChanged: (String newValue) =>
                        context.read<SettingsBloc>().add(
                              SettingsUpdatedEvent(
                                state.settingsModel.copyWith(
                                  encoder: newValue,
                                ),
                              ),
                            ),
                  ),
                  CustomDivider(title: 'Output appearance'),
                  CustomSwitchListTile(
                    title: 'No font color',
                    subtitle: "For .srt/.sami/.vtt, don't add font color tags.",
                    value: state.settingsModel.nofontcolor,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                nofontcolor: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'No HTML escape',
                    subtitle:
                        "For .srt/.sami/.vtt, don't covert html unsafe character.",
                    value: state.settingsModel.nohtmlescape,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                nohtmlescape: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'No typesetting',
                    subtitle:
                        "For .srt/.sami/.vtt, don't add typesetting tags.",
                    value: state.settingsModel.notypesetting,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                notypesetting: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Trim',
                    subtitle: 'Trim ouput lines',
                    value: state.settingsModel.trim,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                trim: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomTextField(
                    title: 'Default color',
                    subtitle:
                        'Add the color you want in RGB, such as #FF0000 for red.',
                    controller: defaultColorController,
                    onEditingComplete: () {
                      RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')
                              .hasMatch(defaultColorController.text)
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    defaultcolor: defaultColorController.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'This default color hex is not valid');
                    },
                  ),
                  CustomDivider(title: 'Customize output'),
                  CustomSwitchListTile(
                    title: 'Sentence capitalization.',
                    subtitle: 'Use if you hate ALL CAPS in subtitles.',
                    value: state.settingsModel.sentencecap,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                sentencecap: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Kid friendly.',
                    subtitle: 'Censors profane words from subtitles.',
                    value: state.settingsModel.kf,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                kf: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Split by sentence',
                    subtitle:
                        'Split output text so each frame contains a complete sentence. Timings are adjusted based on number of characters',
                    value: state.settingsModel.splitbysentence,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                splitbysentence: value,
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
