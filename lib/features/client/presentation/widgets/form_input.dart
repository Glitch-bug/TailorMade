import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/presentation/widgets/label.dart';

class FormInput extends StatelessWidget {
  final String label;
  String? hintText;
  final TextInputType inputType;

  FormInput({
    required this.label,
    this.hintText,
    this.inputType = TextInputType.text,
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

              keyboardType: inputType,
              inputFormatters: (inputType == TextInputType.number)?[
                FilteringTextInputFormatter.digitsOnly,
              ]:[],
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
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
