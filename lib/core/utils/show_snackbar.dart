import 'package:flutter/material.dart';

void showSnackBar({context, text, color = Colors.green, textColor = Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          )),
      behavior: SnackBarBehavior.fixed,
    ),
  );
}
