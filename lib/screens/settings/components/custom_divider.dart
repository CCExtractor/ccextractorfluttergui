import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String title;
  final String? description;
  const CustomDivider({Key? key, required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 19,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              if (description != null) SizedBox(height: 10),
              Text(
                description ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
