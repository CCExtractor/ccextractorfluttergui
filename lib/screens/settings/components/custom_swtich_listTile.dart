import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function onTap;
  const CustomSwitchListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 8,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Container(
        child: Switch(
          activeColor: Theme.of(context).colorScheme.secondary,
          value: value,
          onChanged: (value) => onTap(value),
        ),
      ),
    );
  }
}
