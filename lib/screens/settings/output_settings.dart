import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/screens/settings/components/current_command.dart';
import 'package:ccxgui/utils/constants.dart';
import 'components/custom_divider.dart';
import 'components/custom_dropdown.dart';
import 'components/custom_path_button.dart';
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
          TextEditingController minlevdist =
              TextEditingController(text: state.settingsModel.minlevdist);
          TextEditingController maxlevdist =
              TextEditingController(text: state.settingsModel.maxlevdist);
          TextEditingController startcreditstext =
              TextEditingController(text: state.settingsModel.startcreditstext);
          TextEditingController startcreditsnotbefore = TextEditingController(
              text: state.settingsModel.startcreditsnotbefore);
          TextEditingController startcreditsnotafter = TextEditingController(
              text: state.settingsModel.startcreditsnotafter);
          TextEditingController startcreditsforatleast = TextEditingController(
              text: state.settingsModel.startcreditsforatleast);
          TextEditingController startcreditsforatmost = TextEditingController(
              text: state.settingsModel.startcreditsforatmost);
          TextEditingController endcreditstext =
              TextEditingController(text: state.settingsModel.endcreditstext);
          TextEditingController endcreditsforatleast = TextEditingController(
              text: state.settingsModel.endcreditsforatleast);
          TextEditingController endcreditsforatmost = TextEditingController(
              text: state.settingsModel.endcreditsforatmost);
          TextEditingController service =
              TextEditingController(text: state.settingsModel.service);
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
                        "For .srt/.sami/.vtt, don't convert html unsafe character.",
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
                  CustomGetFilePathButton(
                    title: 'Profanity file',
                    subtitle:
                        "Add the contents of 'file' to the list of words, that must be censored",
                    currentPath: state.settingsModel.profanityFile,
                    clearField: () {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                profanityFile: '',
                              ),
                            ),
                          );
                    },
                    saveToConfig: (String filePath) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                profanityFile: filePath,
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
                  CustomGetFilePathButton(
                    title: 'Sentence cap file',
                    subtitle:
                        "Add the contents of 'file' to the list of words, that must be capitalized.",
                    currentPath: state.settingsModel.capFile,
                    clearField: () {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                capFile: '',
                              ),
                            ),
                          );
                    },
                    saveToConfig: (String filePath) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                capFile: filePath,
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
                    items: dropdownListMap['xmltv']!.keys.toList(),
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
                  CustomDropDown(
                    title: 'Roll up',
                    subtitle:
                        'If having 3 or 4 lines annoys, use this to have 1,2,3 lines in roll-up captions',
                    value: state.settingsModel.rollUp,
                    items: rollUp,
                    onChanged: (String newValue) {
                      context.read<SettingsBloc>().add(
                            SettingsUpdatedEvent(
                              state.settingsModel.copyWith(
                                rollUp: newValue,
                              ),
                            ),
                          );
                    },
                  ),
                  CustomDropDown(
                    title: 'Stream Type',
                    subtitle:
                        "Assume the data is of this type, don't autodetect.",
                    value: state.settingsModel.streamtype,
                    items: dropdownListMap['streamtype']!.keys.toList(),
                    onChanged: (value) => context.read<SettingsBloc>().add(
                          SettingsUpdatedEvent(
                            state.settingsModel.copyWith(
                              streamtype: value,
                            ),
                          ),
                        ),
                  ),
                  CustomDivider(
                    title: '708 closed caption decoder',
                  ),
                  CustomTextField(
                    title: '708 service numbers',
                    subtitle:
                        'Enable CEA-708 (DTVCC) captions processing for the listed services. The parameter is a comma delimited list of services numbers, such as "1,2" to process the primary and secondary language services. Pass "all" to process all services found.',
                    onEditingComplete: () => context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settingsModel.copyWith(
                              service: service.text,
                            ),
                          ),
                        ),
                    controller: service,
                  ),
                  CustomDivider(
                    title: 'Live typo correction',
                    description:
                        "Some TV stations add captions manually live, which leads to typos which are quickly corrected (by resending the correct text). This causes some problems when detecting duplicate text because the text is different due to the typos. In order to add some tolerance we use and algorithm called Levenshtein distance. You can tweak its values here. Note: It only applies for teletext (because we've only seen this happen on European programming) and most likely you do not need it.",
                  ),
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
                    title: 'Maximun Levenshtein distance percentage',
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
                  ),
                  CustomDivider(title: 'Add credits options'),
                  CustomTextField(
                    title: 'Start credits',
                    subtitle:
                        'Write this text as start credits. Can be separated with \\n',
                    onEditingComplete: () {
                      context.read<SettingsBloc>().add(
                            SaveSettingsEvent(
                              state.settingsModel.copyWith(
                                startcreditstext: startcreditstext.text,
                              ),
                            ),
                          );
                    },
                    controller: startcreditstext,
                  ),
                  CustomTextField(
                    title: "Don't start credits before",
                    subtitle:
                        "Don't display the start credits before this time (S, or MM:SS).",
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(startcreditsnotbefore.text) ||
                              startcreditsnotbefore.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    startcreditsnotbefore:
                                        startcreditsnotbefore.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: startcreditsnotbefore,
                  ),
                  CustomTextField(
                    title: "Don't start credits after",
                    subtitle:
                        "Don't display the start credits after this time (S, or MM:SS).",
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(startcreditsnotafter.text) ||
                              startcreditsnotafter.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    startcreditsnotafter:
                                        startcreditsnotafter.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: startcreditsnotafter,
                  ),
                  CustomTextField(
                    title: 'Display start credits for atleast',
                    subtitle:
                        'Start credits need to be displayed for at least this much time (S, or MM:SS).',
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(startcreditsforatleast.text) ||
                              startcreditsforatleast.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    startcreditsforatleast:
                                        startcreditsforatleast.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: startcreditsforatleast,
                  ),
                  CustomTextField(
                    title: 'Display start credits for atmost',
                    subtitle:
                        'Start credits need to be displayed for at atmost this much time (S, or MM:SS).',
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(startcreditsforatmost.text) ||
                              startcreditsforatmost.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    startcreditsforatmost:
                                        startcreditsforatmost.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: startcreditsforatmost,
                  ),
                  CustomTextField(
                    title: 'End credits',
                    subtitle:
                        'Write this text as end credits. Can be separated with \\n',
                    onEditingComplete: () {
                      context.read<SettingsBloc>().add(
                            SaveSettingsEvent(
                              state.settingsModel.copyWith(
                                endcreditstext: endcreditstext.text,
                              ),
                            ),
                          );
                    },
                    controller: endcreditstext,
                  ),
                  CustomTextField(
                    title: 'Display end credits for atleast',
                    subtitle:
                        'End credits need to be displayed for at atleast this much time (S, or MM:SS).',
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(endcreditsforatleast.text) ||
                              endcreditsforatleast.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    endcreditsforatleast:
                                        endcreditsforatleast.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: endcreditsforatleast,
                  ),
                  CustomTextField(
                    title: 'Display end credits for atmost',
                    subtitle:
                        'End credits need to be displayed for at atmost this much time (S, or MM:SS).',
                    onEditingComplete: () {
                      RegExp(r'^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$')
                                  .hasMatch(endcreditsforatmost.text) ||
                              endcreditsforatmost.text.isEmpty
                          ? context.read<SettingsBloc>().add(
                                SaveSettingsEvent(
                                  state.settingsModel.copyWith(
                                    endcreditsforatmost:
                                        endcreditsforatmost.text,
                                  ),
                                ),
                              )
                          : CustomSnackBarMessage.show(
                              context, 'Invalid time format');
                    },
                    controller: endcreditsforatmost,
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
