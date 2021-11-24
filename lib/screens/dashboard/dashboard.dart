import 'package:flutter/material.dart';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/repositories/ccextractor.dart';
import 'package:ccxgui/screens/dashboard/components/add_files.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/screens/dashboard/components/multi_process_tile.dart';
import 'package:ccxgui/screens/dashboard/components/process_tile.dart';
import 'package:ccxgui/screens/dashboard/components/udp_button.dart';
import 'package:ccxgui/utils/constants.dart';
import 'components/start_stop_button.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: AddFilesButton(),
              ),
              Expanded(
                child: ListenOnUDPButton(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: SelectedFilesContainer(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8,
            ),
            child: LogsContainer(),
          ),
        ],
      ),
    );
  }
}

class ClearFilesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProcessBloc, ProcessState>(
      listenWhen: (previous, current) =>
          previous.exitCode !=
          current
              .exitCode, // we reset the exit code everytime so listen only when a new version actually comes not from some other state change before reset error code state comes
      listener: (context, processState) {
        if (CCExtractor.exitCodes[processState.exitCode] != null &&
            processState.exitCode != 0) {
          CustomSnackBarMessage.show(
              context, CCExtractor.exitCodes[processState.exitCode]!);
          context.read<ProcessBloc>().add(ResetProcessError());
        }
      },
      builder: (context, processState) {
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, dashboardState) {
            return MaterialButton(
              onPressed: () {
                dashboardState.files.isEmpty
                    ? null
                    : showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Warning'),
                          content: Text(
                            'Are you sure you want to remove all the selected\nfiles and cancel any files that is running?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ProcessBloc>().add(
                                      ProcessRemoveAll(),
                                    );
                                context.read<DashboardBloc>().add(
                                      RemoveAllFiles(),
                                    );
                                Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                      );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Clear list',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.clear_all,
                      color: dashboardState.files.isEmpty
                          ? Colors.grey
                          : Colors.amber,
                      size: 30,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SelectedFilesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) {
        List<XFile> files = detail.urls.map((e) => XFile(e.path)).toList();
        context.read<DashboardBloc>().add(
              NewFileAdded(files),
            );
        context.read<ProcessBloc>().add(
              ProcessFilesSubmitted(files),
            );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kBgLightColor,
        ),
        height: MediaQuery.of(context).size.height / 2,
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state.alreadyPresent) {
              CustomSnackBarMessage.show(
                  context, 'Already selected files were ignored');
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: kBgDarkColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selected files',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          ClearFilesButton(),
                          StartStopButton(),
                        ],
                      ),
                    ],
                  ),
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                    if (settingsState is CurrentSettingsState) {
                      return Expanded(
                        child: state.files.isNotEmpty
                            ? Scrollbar(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount:
                                      settingsState.settingsModel.splitMode &&
                                              state.files.length > 1
                                          ? 1
                                          : state.files.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: kBgLightColor,
                                      child: settingsState
                                                  .settingsModel.splitMode &&
                                              state.files.length > 1
                                          ? MultiProcessTile(files: state.files)
                                          : ProcessTile(
                                              file: state.files[index]),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                  'No files selected',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                      );
                    }
                    return Center(
                      child: Text(
                        'Loading settings, this should be super fast so if this is stuck something is broken, please open a issue on github',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LogsContainer extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (context, state) {
        WidgetsBinding.instance!.addPostFrameCallback(
          (_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              );
            }
          },
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logs',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                color: kBgLightColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Resolution: ${state.videoDetails.isNotEmpty ? "${state.videoDetails[0]} * ${state.videoDetails[1]}" : ''}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      'Aspect ratio:  ${state.videoDetails.isNotEmpty ? state.videoDetails[2].substring(5) : ''}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Framerate:  ${state.videoDetails.isNotEmpty ? state.videoDetails[3].substring(5) : ''}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: kBgLightColor,
              ),
              height: MediaQuery.of(context).size.height / 4,
              child: state.log.isNotEmpty
                  ? Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.log[index],
                              style: TextStyle(
                                color: state.log[index]
                                        .contains(RegExp(r'\d+:\d+-\d+:\d+'))
                                    ? Colors.amber
                                    : Colors.white,
                              ),
                            ),
                          );
                        },
                        itemCount: state.log.length,
                      ),
                    )
                  : Center(
                      child: Text(
                          'Start processing a file to see output genrated here'),
                    ),
            ),
          ],
        );
      },
    );
  }
}
