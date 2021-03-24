import 'dart:math';
import 'package:flutter/material.dart';

class ProcessTile extends StatefulWidget {
  final bool isComepleted;

  const ProcessTile({Key? key, required this.isComepleted}) : super(key: key);
  @override
  _ProcessTileState createState() => _ProcessTileState();
}

class _ProcessTileState extends State<ProcessTile> {
  bool isVisible = false;
  final AlertDialog dialog = AlertDialog(
    title: Text('Settings'),
    contentPadding: EdgeInsets.only(left: 24, top: 18, right: 24),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Text("Add settings here like extraction format"),
        SizedBox(
          height: 12,
        ),
        Text("select output path"),
        SizedBox(
          height: 12,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isVisible = true;
          });
        },
        onExit: (event) {
          setState(() {
            isVisible = false;
          });
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 30),
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "EBQNhhMJhZ5ZrhQZIkthZ0h9T81k81D7cWerZ38gRmmM7IAN0By7A6fPqR0ltX2UNiTw85W3w5BlMZmLhaqnnijp886uNLcwGJOJ",
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  isVisible && !widget.isComepleted
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.greenAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.stop,
                                size: 30,
                                color: Colors.redAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  showDialog<void>(
                                      context: context,
                                      builder: (context) => dialog);
                                },
                                icon: Icon(
                                  Icons.settings,
                                  size: 25,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      child: widget.isComepleted
                          ? Icon(
                              Icons.check_outlined,
                              size: 30,
                            )
                          : CircularProgressIndicator(
                              // : Colors.green,
                              value: 0.4,
                              backgroundColor: Colors.white,
                            ),
                      height: 18,
                      width: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // decoration: BoxDecoration(
          //   color: kBgLightColor,
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(
          //       10,
          //     ),
          //   ),
          // ),
          height: 75,
        ),
      ),
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
