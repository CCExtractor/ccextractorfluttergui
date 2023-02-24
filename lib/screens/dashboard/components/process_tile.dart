import 'package:flutter/material.dart';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/start_stop_button.dart';

class ProcessTile extends StatefulWidget {
  final XFile file;
  const ProcessTile({
    Key? key,
    required this.file,
  }) : super(key: key);
  @override
  _ProcessTileState createState() => _ProcessTileState();
}

class _ProcessTileState extends State<ProcessTile> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.file.name,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.file.path,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: BlocBuilder<ProcessBloc, ProcessState>(
                    builder: (context, state) {
                      if (state.processed.contains(widget.file)) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Icon(Icons.check),
                        );
                      } else if (widget.file == state.current) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                  strokeWidth: 4,
                                  value: int.parse(state.progress) / 100,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Warning'),
                                          content: Text(
                                            'Are you sure you want to remove the selected\nfile and cancel any files that is running?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                StartStopButton();
                                                context
                                                    .read<DashboardBloc>()
                                                    .add(
                                                      FileRemoved(widget.file),
                                                    );
                                                try {
                                                  context
                                                      .read<ProcessBloc>()
                                                      .add(
                                                        ProcessKill(
                                                            widget.file),
                                                      );
                                                } catch (e) {
                                                  print(
                                                      'processing for this file never started');
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes'),
                                            ),
                                          ],
                                        ));
                                print("process_tile");
                                print(state.progress);
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            context.read<DashboardBloc>().add(
                                  FileRemoved(widget.file),
                                );
                            try {
                              context.read<ProcessBloc>().add(
                                    ProcessFileRemoved(widget.file),
                                  );
                            } catch (e) {
                              print('processing for this file never started');
                            }
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
