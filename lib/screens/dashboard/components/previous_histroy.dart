import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/screens/dashboard/components/expandable_container.dart';
import 'package:ccxgui/screens/dashboard/components/process_tile.dart';
import 'package:flutter/material.dart';

class PreviousHistroy extends StatefulWidget {
  @override
  _PreviousHistroyState createState() => _PreviousHistroyState();
}

class _PreviousHistroyState extends State<PreviousHistroy> {
  bool expandFlag = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: MaterialButton(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            elevation: 0,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Previous history",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      expandFlag
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                expandFlag = !expandFlag;
              });
            }),
      ),
      ExpandableContainer(
        expanded: expandFlag,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                color: kBgLightColor,
                child: ProcessTile(
                  isComepleted: true,
                ),
              ),
            );
          },
        ),
      )
    ]);
  }
}
