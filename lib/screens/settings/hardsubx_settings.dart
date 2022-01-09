import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/screens/settings/components/current_command.dart';
import 'package:ccxgui/screens/settings/components/custom_divider.dart';
import 'package:ccxgui/screens/settings/components/custom_dropdown.dart';
import 'package:ccxgui/screens/settings/components/custom_swtich_listTile.dart';
import 'package:ccxgui/screens/settings/components/custom_textfield.dart';
import 'package:ccxgui/utils/constants.dart';

class HardSubxSettingsScreen extends StatelessWidget {
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
          TextEditingController subColorController =
              TextEditingController(text: state.settingsModel.subcolor);
          TextEditingController minSubDurationController =
              TextEditingController(text: state.settingsModel.minSubDuration);
          TextEditingController confThreshController =
              TextEditingController(text: state.settingsModel.confThresh);
          TextEditingController whiteThreshController =
              TextEditingController(text: state.settingsModel.whiteThresh);
          TextEditingController dvblangController =
              TextEditingController(text: state.settingsModel.dvblang);
          TextEditingController ocrlangController =
              TextEditingController(text: state.settingsModel.ocrlang);
          TextEditingController mkvlangController =
              TextEditingController(text: state.settingsModel.mkvlang);

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
              child: ListView(
                controller: controller,
                children: [
                  CustomSwitchListTile(
                    title: 'HardSubx',
                    subtitle:
                        'Enable the burned-in subtitle extraction subsystem.',
                    value: state.settingsModel.hardsubx,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                hardsubx: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Ticker text',
                    subtitle:
                        'Search for burned-in ticker text at the bottom of the screen',
                    value: state.settingsModel.tickertext,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                tickertext: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDropDown(
                    title: 'OCR mode',
                    subtitle:
                        'Set the OCR mode to either frame-wise, word-wise or letter-wise',
                    value: state.settingsModel.ocrMode,
                    items: ocrMode,
                    onChanged: (String newValue) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                ocrMode: newValue,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomTextField(
                    title: 'Subtitles color',
                    subtitle:
                        'Specify the color of the subtitles, by HSV color chart values.',
                    intOnly: true,
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              subcolor: subColorController.text,
                            ),
                          ),
                        ),
                    controller: subColorController,
                  ),
                  CustomTextField(
                    title: 'Minimum subtitles duration',
                    subtitle:
                        'Specify the minimum duration that a subtitle line must exist on the screen. (in seconds)',
                    intOnly: true,
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              minSubDuration: minSubDurationController.text,
                            ),
                          ),
                        ),
                    controller: minSubDurationController,
                  ),
                  CustomSwitchListTile(
                    title: 'Detect italics',
                    subtitle:
                        'Specify whether italics are to be detected from the OCR text.',
                    value: state.settingsModel.detectItalics,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                detectItalics: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomTextField(
                    title: 'Confidence threshold',
                    subtitle:
                        'Specify the classifier confidence threshold between 1 and 100',
                    intOnly: true,
                    onEditingComplete: () {
                      if (confThreshController.text.isEmpty ||
                          (0.0 <= double.parse(confThreshController.text) &&
                              double.parse(confThreshController.text) <=
                                  100.0)) {
                        context.read<SettingsBloc>().add(
                              SaveSettingsEvent(
                                state.settingsModel.copyWith(
                                  confThresh: confThreshController.text,
                                ),
                              ),
                            );
                      } else {
                        CustomSnackBarMessage.show(
                            context, 'Please enter a value between 1 and 100');
                      }
                    },
                    controller: confThreshController,
                  ),
                  CustomTextField(
                    title: 'Whiteness threshold',
                    subtitle:
                        'For white subtitles only, specify the luminance threshold between 1 and 100',
                    intOnly: true,
                    onEditingComplete: () {
                      if (whiteThreshController.text.isEmpty ||
                          (0.0 <= double.parse(whiteThreshController.text) &&
                              double.parse(whiteThreshController.text) <=
                                  100.0)) {
                        context.read<SettingsBloc>().add(
                              SaveSettingsEvent(
                                state.settingsModel.copyWith(
                                  whiteThresh: whiteThreshController.text,
                                ),
                              ),
                            );
                      } else {
                        CustomSnackBarMessage.show(
                            context, 'Please enter a value between 1 and 100');
                      }
                    },
                    controller: whiteThreshController,
                  ),
                  CustomDivider(title: 'Misc OCR related settings'),
                  CustomDropDown(
                    title: 'Quant mode',
                    subtitle:
                        "How to quantize the bitmap before passing it to tesseract for OCR'ing.",
                    value: state.settingsModel.quant,
                    items: dropdownListMap['quant']!.keys.toList(),
                    onChanged: (String newValue) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                quant: newValue,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDropDown(
                    title: 'OEM',
                    subtitle: 'Select the OEM mode for Tesseract.',
                    value: state.settingsModel.oem,
                    items: dropdownListMap['oem']!.keys.toList(),
                    onChanged: (String newValue) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                oem: newValue,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomTextField(
                    title: 'DVB lang',
                    subtitle:
                        "For DVB subtitles, select which language's caption stream will be processed. e.g. 'eng' for English.",
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              dvblang: dvblangController.text,
                            ),
                          ),
                        ),
                    controller: dvblangController,
                  ),
                  CustomTextField(
                    title: 'OCR lang',
                    subtitle:
                        'Manually select the name of the Tesseract .traineddata. Helpful if you want to OCR a caption stream of  one language with the data of another language.',
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              ocrlang: ocrlangController.text,
                            ),
                          ),
                        ),
                    controller: ocrlangController,
                  ),
                  CustomTextField(
                    title: 'MKV lang',
                    subtitle:
                        "For MKV subtitles, select which language's caption stream will be processed. e.g. 'eng' for English.",
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              mkvlang: mkvlangController.text,
                            ),
                          ),
                        ),
                    controller: mkvlangController,
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
