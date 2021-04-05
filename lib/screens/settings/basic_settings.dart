import 'package:ccxgui/screens/dashboard/dashboard.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BasicSettingsScreen extends StatefulWidget {
  @override
  _BasicSettingsScreenState createState() => _BasicSettingsScreenState();
}

class _BasicSettingsScreenState extends State<BasicSettingsScreen> {
  late String selectedOutputFormat;
  late bool append;
  late bool autoprogram;
  TextEditingController outputFileNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var settingsBox = Hive.box("settingsBox");
    selectedOutputFormat = settingsBox.get("output_format");
    append = settingsBox.get("append");
    autoprogram = settingsBox.get("autoprogram");
    outputFileNameController.text = settingsBox.get("output_file_name");
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
                onPressed: () {
                  var settingsBox = Hive.box("settingsBox");
                  settingsBox.put("append", append);
                  settingsBox.put("autoprogram", autoprogram);
                  settingsBox.put("output_format", selectedOutputFormat);
                  settingsBox.put(
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
      body: Padding(
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                      isDense: true),
                  cursorColor: Colors.transparent,
                ),
                width: Responsive.isDesktop(context) ? 300 : 100,
              ),
            ),
            ListTile(
              title: Text("Output file format"),
              subtitle:
                  Text("This will generate the output in the selected format."),
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
      ),
    );
  }
}
