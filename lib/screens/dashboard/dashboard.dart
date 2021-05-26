// Flutter imports:
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
              Expanded(child: AddFilesButton()),
              Expanded(child: ListenOnUDPButton()),
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectedFilesContainer()),
          Padding(
            // TODO: bundle this Logs text in LogsContainer
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('Logs', style: TextStyle(fontSize: 20)),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: LogsContainer()),
        ],
      ),
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
                            context.read<ProcessBloc>().add(ProcessStopped()),
                            CustomSnackBarMessage.show(
                                context, 'Process after ongoing file stopped.')
                          }
                        : {
                            context.read<ProcessBloc>().add(ProcessStarted()),
                            CustomSnackBarMessage.show(
                                context, 'Process started.')
                          };
              },
              child: processState.started
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.stop,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Stop all',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
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
                            'Start all',
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

class CustomSnackBarMessage {
  final String message;

  const CustomSnackBarMessage({
    required this.message,
  });

  // ignore: always_declare_return_types
  static show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(message),
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 1.5,
          bottom: 20,
          right: 20,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class SelectedFilesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kBgLightColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          )),
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
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected files',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    StartStopButton(),
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
          children: [
            Container(
              decoration: BoxDecoration(
                color: kBgLightColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    10,
                  ),
                  topRight: Radius.circular(
                    10,
                  ),
                ),
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    10,
                  ),
                  bottomRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height / 4,
              child: Scrollbar(
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
              ),
            ),
          ],
        );
      },
    );
  }
}
