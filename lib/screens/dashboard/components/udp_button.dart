import 'package:flutter/material.dart';

import 'package:ccxgui/utils/constants.dart';

class ListenOnUDPButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  'Read the input via UDP (listening in the specified port)'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: '127.0.0.1',
                      decoration: InputDecoration(
                        hintText: 'Enter host here',
                        labelText: 'Host: ',
                        labelStyle: TextStyle(fontSize: 18),
                        hintStyle: TextStyle(height: 2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Enter port here',
                        labelText: 'Port: ',
                        labelStyle: TextStyle(fontSize: 18),
                        hintStyle: TextStyle(height: 2),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, right: 12),
                  child: MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Start'),
                  ),
                ),
              ],
            );
          },
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          height: 75,
          child: Center(
            child: Text(
              'Listen on UDP',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
