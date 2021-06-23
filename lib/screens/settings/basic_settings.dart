// Flutter imports:
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/utils/responsive.dart';

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
              title: Text('Basic Settings'),
              actions: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 20, right: 20),
                //   child: MaterialButton(
                //     minWidth: 150,
                //     color: Theme.of(context).colorScheme.secondary,
                //     onPressed: () {
                // context.read<SettingsBloc>().add(
                //       SaveSettingsEvent(state.settingsModel),
                //     );
                //       CustomSnackBarMessage.show(
                //         context,
                //         'Settings applied',
                //       );
                //     },
                //     child: Text(
                //       'Apply',
                //       style: TextStyle(
                //         fontSize: 20,
                //       ),
                //     ),
                //   ),
                // ),
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Output file name (press enter to save)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "This will define the output filename if you don't like the default ones,\nEach file will be appeded with a _1, _2 when needed",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: kBgLightColor,
                          width: Responsive.isDesktop(context) ? 300 : 100,
                          child: TextFormField(
                            onEditingComplete: () =>
                                context.read<SettingsBloc>().add(
                                      SaveSettingsEvent(
                                        state.settingsModel.copyWith(
                                          outputfilename:
                                              outputFileNameController.text,
                                        ),
                                      ),
                                    ),
                            controller: outputFileNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 6,
                              ),
                              isDense: true,
                            ),
                            cursorColor: Colors.transparent,
                          ),
                        ),
                      ],
                      // title:
                      // subtitle: Text(
                      //   "This will define the output filename if you don't like the default ones, each file will be appeded with a _1, _2 when needed",
                      // ),
                      // trailing:
                    ),
                  ),
                  ListTile(
                    title: Text('Output file format'),
                    subtitle: Text(
                        'This will generate the output in the selected format.'),
                    trailing: Container(
                      width: Responsive.isDesktop(context) ? 300 : 100,
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        value: state.settingsModel.outputformat,
                        items: outputFormats.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    outputformat: newValue,
                                  ),
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Append'),
                    subtitle: Text(
                      'This will prevent overwriting of existing files. The output will be appended instead.',
                    ),
                    trailing: Container(
                      child: Checkbox(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: state.settingsModel.append,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    append: value,
                                  ),
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Autoprogram'),
                    subtitle: Text(
                      "If there's more than one program in the stream, this will the first one we find that contains a suitable stream.",
                    ),
                    trailing: Container(
                      child: Switch(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: state.settingsModel.autoprogram,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    autoprogram: value,
                                  ),
                                ),
                              );
                        },
                      ),
                    ),
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
