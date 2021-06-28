// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/utils/constants.dart';
import 'components/custom_dropdown.dart';
import 'components/custom_swtich_listTile.dart';
import 'components/custom_textfield.dart';

class BasicSettingsScreen extends StatelessWidget {
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
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Basic settings',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  CustomTextField(
                    title: 'Output file name (press enter to save)',
                    subtitle:
                        "This will define the output filename if you don't like the default ones,\nEach file will be appeded with a _1, _2 when needed",
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
                    value: state.settingsModel.inputformat,
                    items: inputFormats,
                    onChanged: (String newValue) =>
                        context.read<SettingsBloc>().add(
                              SettingsUpdatedEvent(
                                state.settingsModel.copyWith(
                                  inputformat: newValue,
                                ),
                              ),
                            ),
                  ),
                  CustomDropDown(
                    title: 'Output file format',
                    subtitle:
                        'This will generate the output in the selected format.',
                    value: state.settingsModel.outputformat,
                    items: outputFormats,
                    onChanged: (String newValue) =>
                        context.read<SettingsBloc>().add(
                              SettingsUpdatedEvent(
                                state.settingsModel.copyWith(
                                  outputformat: newValue,
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
