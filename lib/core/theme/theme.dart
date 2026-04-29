import 'package:flutter/material.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';


class AppTheme {
  static _border([Color  color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10)
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(),
      errorBorder: _border(AppPallete.errorColor)
    )
  );
}