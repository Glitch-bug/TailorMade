import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String label;
  final String item;
  const Item({required this.label, required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 250,
        child: Text.rich(
          TextSpan(
            text: "$label\n",
            style: textTheme.bodyMedium,
            children: [
              TextSpan(
                text: item,
                style: textTheme.labelLarge
              )
            ] 
          )
        )
        
      ),
    );
  }
}
