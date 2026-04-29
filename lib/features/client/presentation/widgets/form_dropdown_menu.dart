import 'package:flutter/material.dart';
import 'package:tailor_made/features/client/presentation/widgets/label.dart';

class FormDropDownMenu extends StatelessWidget {
  final String label;
  final List<Map<String,String>> items;
  const FormDropDownMenu({
    required this.items,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(label:label),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:6.0),
            child: DropdownButtonFormField(
              onChanged: (newValue) {},
              value: items.first["value"],
              items: items.map((item) => DropdownMenuItem(
                  value: item["value"],
                  child: Text(
                    item["label"] ?? "",
                  ),
                )
              
              ).toList().cast(),
            ),
          ),
        ],
      ),
    );
  }
}


