import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final processStarted = context.select<ProcessBloc, bool>(
          (bloc) => bloc.state.started,
        );
        final hasFiles = context.select<DashboardBloc, bool>(
          (bloc) => bloc.state.files.isNotEmpty,
        );
        final fileCount = context.select<DashboardBloc, int>(
          (bloc) => bloc.state.files.length,
        );
        final splitMode = context.select<SettingsBloc, bool>(
          (bloc) => bloc.state is CurrentSettingsState
              ? (bloc.state as CurrentSettingsState).settingsModel.splitMode
              : false,
        );

        return Tooltip(
          message: processStarted ? 'Stop all processing' : 'Start processing',
          child: MaterialButton(
            onPressed: hasFiles
                ? () =>
                    _handlePress(context, processStarted, splitMode, fileCount)
                : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    processStarted ? 'Stop all' : 'Start all',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    processStarted ? Icons.stop : Icons.play_arrow,
                    color: processStarted
                        ? Colors.redAccent
                        : hasFiles
                            ? Colors.greenAccent
                            : Colors.grey,
                    size: 30,
                    semanticLabel: processStarted ? 'Stop' : 'Start',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handlePress(BuildContext context, bool processStarted, bool splitMode,
      int fileCount) {
    if (processStarted) {
      context.read<ProcessBloc>().add(StopAllProcess());
      CustomSnackBarMessage.show(context, 'Cancelled process on all files.');
    } else {
      if (splitMode && fileCount > 1) {
        context.read<ProcessBloc>().add(StartProcessInSplitMode());
      } else {
        context.read<ProcessBloc>().add(StartAllProcess());
      }
      CustomSnackBarMessage.show(context, 'Process started.');
    }
  }
}
