import 'package:flutter/material.dart';

import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';

import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/utils/responsive.dart';

class CustomGetFilePathButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final String currentPath;
  final Function(String path) saveToConfig;
  final VoidCallback clearField;
  const CustomGetFilePathButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.saveToConfig,
    required this.currentPath,
    required this.clearField,
  }) : super(key: key);

  @override
  _CustomGetFilePathButtonState createState() =>
      _CustomGetFilePathButtonState();
}

class _CustomGetFilePathButtonState extends State<CustomGetFilePathButton> {
  String path = '';

  void _getFilePath(BuildContext context) async {
    final XFile? file = await FileSelectorPlatform.instance.openFile();
    if (file == null) {
      // Operation was canceled by the user.
      return;
    }
    widget.saveToConfig(file.path);

    setState(() {
      path = file.path;
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    _scrollController.hasClients
        ? _scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          )
        : null;
    path = widget.currentPath;
    if (path.isEmpty) path = 'Browse';
    return ListTile(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      trailing: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: Responsive.isDesktop(context) ? 300 : 100,
          child: Row(
            children: [
              Tooltip(
                message: 'Clear field',
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: widget.clearField,
                  icon: Icon(Icons.delete_outline),
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: Responsive.isDesktop(context) ? 250 : 50,
                height: 46,
                color: kBgLightColor,
                child: MaterialButton(
                  onPressed: () async {
                    _getFilePath(context);
                  },
                  child: SingleChildScrollView(
                    reverse: true,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      path,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
