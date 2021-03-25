import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/models/custom_process.dart';
import 'package:ccxgui/screens/dashboard/components/add_files.dart';
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
                child: Row(
                  children: [
                    MaterialButton(
                      hoverColor: Colors.green.shade900,
                      onPressed: () => null,
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
                    MaterialButton(
                      hoverColor: Colors.red.shade900,
                      onPressed: () => print("stop all"),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              if (index == 6) {
                return AddFilesButton();
              } else {
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
              }
            },
          ),
          PreviousHistroy(),
        ],
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
