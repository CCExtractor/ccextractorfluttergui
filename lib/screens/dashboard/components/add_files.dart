import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFilesButton extends StatelessWidget {
  void _openImageFile(BuildContext context) async {
    final List<XFile> files = await openFiles(acceptedTypeGroups: []);
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    context.read<DashboardBloc>().add(
          NewFileAdded(files),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () => _openImageFile(context),
        child: Container(
          child: Center(
            child: Text(
              "Add more files",
              style: TextStyle(fontSize: 20),
            ),
          ),
          decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          height: 75,
        ),
      ),
    );
  }
}
