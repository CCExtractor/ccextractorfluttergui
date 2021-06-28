import 'package:ccxgui/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final Function onChanged;
  final List<String> items;
  const CustomDropDown(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.value,
      required this.onChanged,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Container(
        width: Responsive.isDesktop(context) ? 300 : 100,
        child: DropdownButton<String>(
          underline: Container(),
          isExpanded: true,
          value: value,
          items: items.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) => onChanged(newValue),
        ),
      ),
    );
  }
}
