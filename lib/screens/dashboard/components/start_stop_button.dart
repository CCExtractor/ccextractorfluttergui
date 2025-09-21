import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';

//TODO: this file can probably be improved
class StartStopButton extends StatefulWidget {
  @override
  State<StartStopButton> createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (context, processState) {
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, dashboardState) {
            return BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
                if (settingsState is CurrentSettingsState) {
                  if (dashboardState.files.isEmpty && processState.started) {
                    context.read<ProcessBloc>().add(
                          StopAllProcess(),
                        );
                  }
                  return MaterialButton(
                    onPressed: () {
                      dashboardState.files.isEmpty
                          ? null
                          : processState.started
                              ? {
                                  context.read<ProcessBloc>().add(
                                        StopAllProcess(),
                                      ),
                                  CustomSnackBarMessage.show(
                                    context,
                                    'Cancelled process on all files.',
                                  )
                                }
                              : {
                                  settingsState.settingsModel.splitMode &&
                                          dashboardState.files.length > 1
                                      ? context.read<ProcessBloc>().add(
                                            StartProcessInSplitMode(),
                                          )
                                      : context.read<ProcessBloc>().add(
                                            StartAllProcess(),
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
                          Text(
                            dashboardState.files.isNotEmpty &&
                                    processState.started
                                ? 'Stop all'
                                : 'Start all',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          dashboardState.files.isNotEmpty &&
                                  processState.started
                              ? Icon(Icons.stop,
                                  color: Colors.redAccent, size: 30)
                              : Icon(
                                  Icons.play_arrow,
                                  color: dashboardState.files.isEmpty
                                      ? Colors.grey
                                      : Colors.greenAccent,
                                  size: 30,
                                ),
                        ],
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        processState.started ? 'Stop all' : 'Start all',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      processState.started
                          ? Icon(Icons.stop, color: Colors.redAccent, size: 30)
                          : Icon(
                              Icons.play_arrow,
                              color: dashboardState.files.isEmpty
                                  ? Colors.grey
                                  : Colors.greenAccent,
                              size: 30,
                            ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
