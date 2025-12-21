import 'package:flutter/material.dart';

import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/utils/constants.dart';

class AddFilesButton extends StatelessWidget {
  const AddFilesButton({super.key});

  void _openVideosFileSelector(BuildContext context) async {
    final List<XFile> files = await FileSelectorPlatform.instance.openFiles(
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'Video',
          extensions: [
            'dvr-ms',
            'm2v',
            'mpg',
            'ts',
            'wtv',
            'mp4',
            'mpg2',
            'vob',
            'mkv',
            'mxf',
          ],
          mimeTypes: ['video/*'],
        ),
      ],
    );
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    context.read<DashboardBloc>().add(
          NewFileAdded(files),
        );
    context.read<ProcessBloc>().add(
          ProcessFilesSubmitted(files),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (context, processState) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            if (settingsState is CurrentSettingsState) {
              final isDisabled =
                  settingsState.settingsModel.splitMode && processState.started;
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Tooltip(
                  message: isDisabled
                      ? 'Cannot add files during split mode processing'
                      : 'Click to add video files for processing',
                  child: Semantics(
                    button: true,
                    label: 'Add more files',
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () => isDisabled
                          ? CustomSnackBarMessage.show(context,
                              "Can't add files when splitMode is enabled and there is a ongoing process")
                          : _openVideosFileSelector(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kBgLightColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        height: 75,
                        child: const Center(
                          child: Text(
                            'Add more files',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kBgLightColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 75,
                child: const Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
