import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Processing xyz"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text(
                  "Summary",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Resolution: 1920 * 1080", style: TextStyle(fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                Text("Aspect ratio: 4:3", style: TextStyle(fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                Text("Frame rate: 29.97", style: TextStyle(fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Text(
                  "Logs",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
