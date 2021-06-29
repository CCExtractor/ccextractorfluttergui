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
          TextEditingController xmltvliveinterval = TextEditingController(
              text: state.settingsModel.xmltvliveinterval);
          TextEditingController xmltvoutputinterval = TextEditingController(
              text: state.settingsModel.xmltvoutputinterval);
          TextEditingController buffersize =
              TextEditingController(text: state.settingsModel.buffersize);
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
                  CustomSwitchListTile(
                    title: 'SEM',
                    subtitle:
                        'Create a .sem file for each output file that is open and delete it on file close. ',
                    value: state.settingsModel.sem,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                sem: value,
                              ),
                            ),
                          );
                    },
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
                  CustomSwitchListTile(
                    title: 'Transcript dates.',
                    subtitle:
                        'In transcripts, write time as YYYYMMDDHHMMss,ms.',
                    value: state.settingsModel.datets,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                datets: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Transcript seconds.',
                    subtitle: 'In transcripts, write time as ss,ms',
                    value: state.settingsModel.sects,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                sects: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Latrus Map',
                    subtitle:
                        'Map Latin symbols to Cyrillic ones in special cases of Russian Teletext files',
                    value: state.settingsModel.latrusmap,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                latrusmap: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'XDS',
                    subtitle:
                        'In timed transcripts, all XDS information will be saved to the output file.',
                    value: state.settingsModel.xds,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                xds: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'LF',
                    subtitle:
                        'Use LF (UNIX) instead of CRLF (DOS, Windows) as line terminator',
                    value: state.settingsModel.lf,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                lf: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'DF',
                    subtitle: 'For MCC Files, force dropframe frame count.',
                    value: state.settingsModel.df,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                df: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Autodash',
                    subtitle:
                        'Based on position on screen, attempt to determine the different speakers and a dash (-) when each of them talks (.srt/.vtt only, -trim required).',
                    value: state.settingsModel.autodash,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                autodash: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(title: 'XMLTV output'),
                  CustomDropDown(
                    title: 'XMLTV',
                    subtitle:
                        'Produce an XMLTV file containing the EPG data from the source TS file',
                    value: state.settingsModel.xmltv,
                    items: xmltv,
                    onChanged: (value) => context.read<SettingsBloc>().add(
                          SettingsUpdatedEvent(
                            state.settingsModel.copyWith(
                              xmltv: value,
                            ),
                          ),
                        ),
                  ),
                  CustomTextField(
                    title: 'XML live interval',
                    subtitle:
                        'Interval of x seconds between writing live mode xmltv output.',
                    controller: xmltvliveinterval,
                    onEditingComplete: () {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                xmltvliveinterval: xmltvliveinterval.text,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomTextField(
                    title: 'XML output interval',
                    subtitle:
                        'Interval of x seconds between writing full file xmltv output.',
                    controller: xmltvoutputinterval,
                    onEditingComplete: () {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                xmltvoutputinterval: xmltvoutputinterval.text,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'XML current',
                    subtitle: 'Only print current events for xmltv output.',
                    value: state.settingsModel.xmltvonlycurrent,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                xmltvonlycurrent: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(title: 'Buffer settings'),
                  CustomSwitchListTile(
                    title: 'Buffer input. ',
                    subtitle: 'Forces input buffering.',
                    value: state.settingsModel.bufferinput,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    bufferinput: value,
                                    nobufferinput: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    bufferinput: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'No buffer input',
                    subtitle: 'Disables input buffering.',
                    value: state.settingsModel.nobufferinput,
                    onTap: (bool value) {
                      value == true
                          ? context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nobufferinput: value,
                                    bufferinput: false,
                                  ),
                                ),
                              )
                          : context.read<SettingsBloc>().add(
                                SettingsUpdatedEvent(
                                  state.settingsModel.copyWith(
                                    nobufferinput: value,
                                  ),
                                ),
                              );
                    },
                  ),
                  CustomTextField(
                    title: 'Buffer size',
                    subtitle:
                        'Specify a size for reading, in bytes (suffix with K or or M for kilobytes and megabytes). Default is 16M.',
                    controller: buffersize,
                    intOnly: true,
                    onEditingComplete: () {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                buffersize: buffersize.text,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'Keep output close',
                    subtitle:
                        'If used then CCExtractor will close the output file after writing each subtitle frame and attempt to create it again when needed.',
                    value: state.settingsModel.koc,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                koc: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDivider(title: '608 closed caption decoder'),
                  CustomSwitchListTile(
                    title: 'Direct roll-up',
                    subtitle:
                        'Direct Roll-Up. When in roll-up mode, write character by character instead of line by line. Note that this produces (much) larger files.',
                    value: state.settingsModel.dru,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                dru: value,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomSwitchListTile(
                    title: 'No roll-up',
                    subtitle:
                        'If you hate the repeated lines caused by the roll-up emulation, you can have ccextractor write only one line at a time, getting rid of these repeated lines.',
                    value: state.settingsModel.norollup,
                    onTap: (value) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                norollup: value,
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
