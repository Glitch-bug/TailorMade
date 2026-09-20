import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, text, color = Colors.green, textColor = Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          )),
      behavior: SnackBarBehavior.fixed,
    ),
  );
}
