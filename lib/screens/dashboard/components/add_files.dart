// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:file_selector/file_selector.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/utils/constants.dart';

class AddFilesButton extends StatelessWidget {
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
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () => _openVideosFileSelector(context),
        child: Container(
          decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          height: 75,
          child: Center(
            child: Text(
              'Add more files',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
