import 'package:ccxgui/utils/responsive.dart';
import 'package:flutter/material.dart';

List<String> settingsTitles = ["Basic", "Advanced", "HardSubx", "Obscure"];

class SettingsDialog extends StatefulWidget {
  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  int _settingsIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SettingsList(
                  onSettingsTap: (int _) {
                    setState(() {
                      _settingsIndex = _;
                    });
                  },
                ),
                flex: Responsive.isDesktop(context) ? 1 : 2,
              ),
              VerticalDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Checkbox(
                              value: true,
                              onChanged: null,
                            ),
                            title: Text(
                                "${settingsTitles[_settingsIndex]} setting name"),
                          );
                        },
                        itemCount: 15,
                      ),
                    ],
                  ),
                ),
                flex: Responsive.isDesktop(context) ? 5 : 5,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  MaterialButton(
                    child: Text("Apply"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SettingsList extends StatelessWidget {
  final void Function(int) onSettingsTap;

  const SettingsList({Key? key, required this.onSettingsTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => onSettingsTap(index),
          title: Text(
            settingsTitles[index],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: settingsTitles.length,
    );

    // ListView(
    //   shrinkWrap: true,
    //   children: [
    //     ListTile(
    //       title: Text("Basic"),
    //     ),
    //     Divider(),
    //     ListTile(
    //       title: Text("Advanced"),
    //     ),
    //     Divider(),
    //     ListTile(
    //       title: Text("HardSubx"),
    //     ),
    //     Divider(),
    //     ListTile(
    //       title: Text("Obscure"),
    //     ),
    //     Divider(),
    //   ],
    // );
  }
}
