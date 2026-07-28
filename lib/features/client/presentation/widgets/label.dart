import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String label;
  const Label({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context){
    final textTheme = Theme.of(context).textTheme;

    return Text(
      label,
      style: textTheme.labelLarge
    );
  }

}