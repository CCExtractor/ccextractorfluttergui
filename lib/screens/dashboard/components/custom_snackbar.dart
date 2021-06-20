import 'package:flutter/material.dart';

class CustomSnackBarMessage {
  final String message;

  const CustomSnackBarMessage({
    required this.message,
  });

  // ignore: always_declare_return_types
  static show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(message),
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 1.5,
          bottom: 20,
          right: 20,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}