// Flutter imports:
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/utils/responsive.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/add_files.dart';
import 'package:ccxgui/screens/dashboard/components/process_tile.dart';
import 'package:ccxgui/screens/dashboard/components/udp_button.dart';
import 'package:ccxgui/utils/constants.dart';

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
              horizontal: 20,
              vertical: 8,
            ),
            child: CurrentCommandContainer(),
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
    return BlocBuilder<ProcessBloc, ProcessState>(
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
                    Icon(
                      Icons.clear_all,
                      color: dashboardState.files.isEmpty
                          ? Colors.grey
                          : Colors.amber,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Clear list',
                      style: TextStyle(
                        fontSize: 20,
                      ),
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

class StartStopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (context, processState) {
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, dashboardState) {
            return MaterialButton(
              onPressed: () {
                dashboardState.files.isEmpty
                    ? null
                    : processState.started
                        ? {
                            context.read<ProcessBloc>().add(
                                  ProcessStopped(),
                                ),
                            CustomSnackBarMessage.show(
                              context,
                              'Cancelled process on all files.',
                            )
                          }
                        : {
                            context.read<ProcessBloc>().add(
                                  ProcessStarted(),
                                ),
                            CustomSnackBarMessage.show(
                              context,
                              'Process started.',
                            )
                          };
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    processState.started
                        ? Icon(Icons.stop, color: Colors.redAccent, size: 30)
                        : Icon(
                            Icons.play_arrow,
                            color: dashboardState.files.isEmpty
                                ? Colors.grey
                                : Colors.greenAccent,
                            size: 30,
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      processState.started ? 'Stop all' : 'Start all',
                      style: TextStyle(
                        fontSize: 20,
                      ),
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
    return Container(
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
              Expanded(
                child: state.files.isNotEmpty
                    ? Scrollbar(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: state.files.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: kBgLightColor,
                              child: ProcessTile(
                                file: state.files[index],
                              ),
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
              ),
            ],
          );
        },
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
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 10.0),
                    //   child: Text(
                    //     'Encoding:  ${state.videoDetails[3]}',
                    //     style: TextStyle(fontSize: 15),
                    //   ),
                    // ),
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
                      )),
          ],
        );
      },
    );
  }
}

class CurrentCommandContainer extends StatelessWidget {
  const CurrentCommandContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is CurrentSettingsState) {
          SettingsModel settings = state.settingsModel;
          List enabledSettings = settings.enabledSettings;
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Command: ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width - 270
                    : MediaQuery.of(context).size.width -
                        56, // remove drawer width
                decoration: BoxDecoration(
                  color: kBgLightColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    'ccextractor --gui_mode_reports ${enabledSettings.map((param) => '--' + param).join(' ')} +[input files]',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
