import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessTile extends StatefulWidget {
  final bool isComepleted;
  final String fileName;
  final String filePath;
  final int fileIndex;
  const ProcessTile({
    Key? key,
    required this.isComepleted,
    required this.fileName,
    required this.filePath,
    required this.fileIndex,
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
                        widget.fileName,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.filePath,
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
                      if (state.finishedAll) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Icon(Icons.check),
                        );
                      }
                      if (int.parse(state.progress!) > 0 &&
                          widget.fileIndex == state.currentIndex &&
                          !state.comepletedIndices.contains(widget.fileIndex))
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.green,
                              strokeWidth: 4,
                              value: int.parse(state.progress!) / 100,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        );
                      else if (state.comepletedIndices
                          .contains(widget.fileIndex)) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Icon(Icons.check),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // IconButton(
                            //   onPressed: () {
                            //     showDialog<void>(
                            //       context: context,
                            //       builder: (context) => SettingsDialog(),
                            //     );
                            //   },
                            //   icon: Icon(
                            //     Icons.settings,
                            //     size: 25,
                            //     color: Colors.blueAccent,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<DashboardBloc>()
                                    .add(FileRemoved(widget.fileIndex));
                                try {
                                  context.read<ProcessBloc>().add(
                                      FileRemovedFromProcessingQueue(
                                          widget.fileIndex));
                                } catch (e) {
                                  print(
                                      "processing for this file never started");
                                }
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        height: 90,
      ),
    );
  }
}
