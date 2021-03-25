import 'package:ccxgui/utils/constants.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class AddFilesButton extends StatelessWidget {
  void _openImageFile(BuildContext context) async {
    final List<XFile> files = await openFiles(acceptedTypeGroups: []);
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    await showDialog(
      context: context,
      builder: (context) => SelectedFilesDisplay(files),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: InkWell(
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

class SelectedFilesDisplay extends StatelessWidget {
  /// The files containing the images
  final List<XFile> files;

  /// Default Constructor
  SelectedFilesDisplay(this.files);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selected file'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...files.map(
            (file) => Text(file.name),
          )
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
