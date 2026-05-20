import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/presentation/widgets/label.dart';

class FormInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType inputType;
  final TextEditingController? controller;

  const FormInput({
    required this.label,
    this.hintText,
    this.inputType = TextInputType.text,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(
            label:label
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:6.0),
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              inputFormatters: (inputType == TextInputType.number)?[
                FilteringTextInputFormatter.digitsOnly,
              ]:[],
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: AppPallete.darkGreyColor,
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
