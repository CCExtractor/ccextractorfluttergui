import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/add_files.dart';
import 'package:ccxgui/screens/dashboard/components/udp_button.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/screens/dashboard/components/process_tile.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: AddFilesButton()),
              Expanded(child: ListenOnUDPButton()),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(20.0),
          //       child: Text(
          //         "Selected files",
          //         style: TextStyle(
          //           fontSize: 20,
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(right: 18),
          //       child: StartStopButton(
          //         files: [],
          //       ),
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SelectedFilesContainer(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              "Logs",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: LogsContainer(),
          ),
        ],
      ),
    );
  }
}

class StartStopButton extends StatefulWidget {
  final List<String> filePaths;
  final bool isEnabled;
  const StartStopButton(
      {Key? key, required this.filePaths, required this.isEnabled})
      : super(key: key);

  @override
  _StartStopButtonState createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  int tempFileNumer = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is CustomProcessFinished) {
          if (tempFileNumer++ < widget.filePaths.length) {
            context.read<DashboardBloc>().add(
                  StartCustomProcess(widget.filePaths[tempFileNumer++]),
                );
          }// TODO: once list is passed to button I cant get the updated one, switch to bloc and get it from state.
        }
      },
      child: MaterialButton(
        hoverColor: Colors.green.shade900,
        onPressed: widget.isEnabled
            ? () {
                context.read<DashboardBloc>().add(
                      StartCustomProcess(widget.filePaths[0]),
                    );
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.play_arrow,
                color: Colors.greenAccent,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Start all",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSnackBarMessage {
  final String message;

  const CustomSnackBarMessage({
    required this.message,
  });

  static show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
        content: Text(message),
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 1.4,
          bottom: 20,
          right: 20,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.amber.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class SelectedFilesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        child: BlocConsumer<DashboardBloc, DashboardState>(
          buildWhen: (previous, current) {
            return current != CustomProcessFinished();
          },
          builder: (context, state) {
            print(state);
            if (state is NewFileSelectedState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Selected files",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: StartStopButton(
                          filePaths: state.filePaths,
                          isEnabled: state.fileNames.length > 0 ? true : false,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: state.fileNames.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: kBgLightColor,
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                print("go to preview screen");
                              },
                              child: ProcessTile(
                                fileName: state.fileNames[index],
                                filePath: state.filePaths[index],
                                isComepleted: false,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Selected files",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: StartStopButton(
                        filePaths: [],
                        isEnabled: false,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBgLightColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "No files selected",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is SelectedFileAlreadyPresentState) {
              CustomSnackBarMessage.show(
                  context, "${state.fileName} was already selected");
            }
          },
        ),
      ),
    );
  }
}

class LogsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: kBgLightColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Resolutionn:  700 * 700",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Text(
                  "Aspect ratio:  4:3",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "Framerate:  29.97",
                  style: TextStyle(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Encoding:  latin1",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.23,
          color: kBgLightColor,
          child: ListView.builder(
            itemCount: 100,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(index.toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
