import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';

class MultiProcessTile extends StatefulWidget {
  final List<XFile> files;
  const MultiProcessTile({
    Key? key,
    required this.files,
  }) : super(key: key);
  @override
  _MultiProcessTileState createState() => _MultiProcessTileState();
}

class _MultiProcessTileState extends State<MultiProcessTile> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          tapHeaderToExpand: true,
          hasIcon: true,
          iconColor: Colors.white,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          iconPadding: EdgeInsets.only(top: 20, left: 20),
        ),
        header: BlocBuilder<ProcessBloc, ProcessState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Processing ${widget.files.length} files in split mode.',
                    style: TextStyle(fontSize: 15),
                  ),
                  state.started && state.progress != '100'
                      ? Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.green,
                            strokeWidth: 4,
                            value: int.parse(state.progress) / 100,
                            backgroundColor: Colors.white,
                          ),
                        )
                      : state.progress == '100'
                          ? Icon(Icons.check)
                          : Container(),
                ],
              ),
            );
          },
        ),
        collapsed: Text(
          'Click to expand',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        expanded: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.files.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text(
                  widget.files[index].name,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              );
            }),
      ),
    );
  }
}
