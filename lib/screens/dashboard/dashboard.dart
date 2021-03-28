import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/add_files.dart';
import 'package:ccxgui/screens/dashboard/components/udp_button.dart';
import 'package:ccxgui/screens/preview/preview_screen.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/screens/dashboard/components/process_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: AddFilesButton()),
              Expanded(child: ListenOnUDPButton()),
            ],
          ),
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
                child: StartStopButton(),
              ),
            ],
          ),
          BlocConsumer<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is NewFileSelectedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.fileNames.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        color: kBgLightColor,
                        child: InkWell(
                          onTap: () {
                            print("go to preview screen");
                            // context.read<ProcessBloc>().add(
                            //       ProcessStarted(CustomProcess()),
                            //     );
                            // Navigator.push(
                            //   context,
                            //   _createRoute(),
                            // );
                          },
                          child: ProcessTile(
                            fileName: state.fileNames[index],
                            filePath: state.filePaths[index],
                            isComepleted: false,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: kBgLightColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "No files selected",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            },
            listener: (context, state) {
              if (state is SelectedFileAlreadyPresentState) {
                CustomSnackBarMessage.show(
                    context, "${state.fileName} was already selected");
              }
            },
          ),
        ],
      ),
    );
  }
}

class StartStopButton extends StatefulWidget {
  @override
  _StartStopButtonState createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  bool hasStarted = false;
  @override
  Widget build(BuildContext context) {
    return hasStarted
        ? MaterialButton(
            hoverColor: Colors.red.shade900,
            onPressed: () {
              setState(() {
                hasStarted = !hasStarted;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.stop,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Stop all",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        : MaterialButton(
            hoverColor: Colors.green.shade900,
            onPressed: () {
              setState(() {
                hasStarted = !hasStarted;
              });
            },
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
          );
  }
}

// ignore: unused_element
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PreviewScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
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
