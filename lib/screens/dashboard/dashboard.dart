import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/models/custom_process.dart';
import 'package:ccxgui/screens/dashboard/components/add_files.dart';
import 'package:ccxgui/screens/dashboard/components/udp_button.dart';
import 'package:ccxgui/screens/preview/preview_screen.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/screens/dashboard/components/previous_histroy.dart';
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
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: kBgLightColor,
                    child: InkWell(
                      onTap: () {
                        context.read<ProcessBloc>().add(
                              ProcessStarted(CustomProcess()),
                            );
                        Navigator.push(
                          context,
                          _createRoute(),
                        );
                      },
                      child: ProcessTile(
                        isComepleted: false,
                      ),
                    ),
                  ),
                );
              }),
          PreviousHistroy(),
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
