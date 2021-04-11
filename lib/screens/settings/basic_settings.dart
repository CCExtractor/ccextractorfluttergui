import 'package:ccxgui/main.dart';
import 'package:ccxgui/screens/dashboard/dashboard.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/utils/responsive.dart';
import 'package:ccxgui/utils/storage_helper.dart';
import 'package:flutter/material.dart';

class BasicSettingsScreen extends StatefulWidget {
  @override
  _BasicSettingsScreenState createState() => _BasicSettingsScreenState();
}

class _BasicSettingsScreenState extends State<BasicSettingsScreen> {
  late String selectedOutputFormat;
  late bool append;
  late bool autoprogram;
  bool isReady = false;
  TextEditingController outputFileNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getSettings().whenComplete(() {
      setState(() {
        isReady = true;
      });
    });
  }

  Future getSettings() async {
    await storage.ready;
    selectedOutputFormat = await storage.getItem("output_format");
    append = await storage.getItem("append");
    autoprogram = await storage.getItem("autoprogram");
    outputFileNameController.text = await storage.getItem("output_file_name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Settings"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: MaterialButton(
                child: Text("Apply"),
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  print(selectedOutputFormat);
                  await storage.ready;
                  await storage.setItem("append", append);
                  await storage.setItem("autoprogram", autoprogram);
                  await storage.setItem("output_format", selectedOutputFormat);
                  await storage.setItem(
                      "output_file_name", outputFileNameController.text);
                  CustomSnackBarMessage.show(
                    context,
                    "Settings applied",
                  );
                }),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: isReady
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Output file name"),
                    subtitle: Text(
                      "This will define the output filename if you don't like the default ones, each file will be appeded with a _1, _2 when needed",
                    ),
                    trailing: Container(
                      color: kBgLightColor,
                      child: TextFormField(
                        controller: outputFileNameController,
                        initialValue: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 6),
                            isDense: true),
                        cursorColor: Colors.transparent,
                      ),
                      width: Responsive.isDesktop(context) ? 300 : 100,
                    ),
                  ),
                  ListTile(
                    title: Text("Output file format"),
                    subtitle: Text(
                        "This will generate the output in the selected format."),
                    trailing: Container(
                      width: Responsive.isDesktop(context) ? 300 : 100,
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        value: selectedOutputFormat,
                        items: outputFormats.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOutputFormat = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Append"),
                    subtitle: Text(
                      "This will prevent overwriting of existing files. The output will be appended instead.",
                    ),
                    trailing: Container(
                      child: Checkbox(
                        activeColor: Theme.of(context).accentColor,
                        value: append,
                        onChanged: (_) {
                          setState(() {
                            append = !append;
                          });
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Autoprogram"),
                    subtitle: Text(
                      "If there's more than one program in the stream, this will the first one we find that contains a suitable stream.",
                    ),
                    trailing: Container(
                      child: Switch(
                        activeColor: Theme.of(context).accentColor,
                        value: autoprogram,
                        onChanged: (_) {
                          setState(() {
                            autoprogram = !autoprogram;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
