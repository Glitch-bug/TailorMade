import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String label;
  const Label({
    required this.label,
    super.key,
  });

  Widget build(BuildContext context){
    return Text(
      label,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w100
      )
    );
  }

}