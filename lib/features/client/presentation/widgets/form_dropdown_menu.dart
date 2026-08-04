import 'package:flutter/material.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/presentation/widgets/label.dart';

class FormDropDownMenu<T extends DropdownEntry> extends StatelessWidget {
  final String label;
  final List<T> items;
  final String? hintText;
  final ValueChanged? onSelected;
  final TextEditingController? controller;
  const FormDropDownMenu({
    required this.items,
    required this.label,
    this.controller,
    this.hintText,
    this.onSelected,
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
            child: DropdownMenu(
              hintText: hintText,
              width: double.infinity,
              controller: controller,
              onSelected: onSelected,
              dropdownMenuEntries:items.map((item) => DropdownMenuEntry(
                label: item.title,
                value: item.value
              )).toList().cast(),
            ),
          ),
        ],
      ),
    );
  }
}


