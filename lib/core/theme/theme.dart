import 'package:flutter/material.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(),
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
        errorBorder: _border(AppPallete.errorColor)),
    elevatedButtonTheme: elevatedButton,
  );

  static ElevatedButtonThemeData elevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.black,
    shape: const BeveledRectangleBorder(),
    backgroundColor: Colors.white,
    textStyle: _labelLarge,
  ));

  static _border([Color color = Colors.white]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 0.3,
      ),
      borderRadius: BorderRadius.zero);

  static const TextTheme textTheme =
      TextTheme(labelLarge: _labelLarge, labelMedium: _labelMedium, bodySmall: _bodySmall);

  static const TextStyle _labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _labelMedium = TextStyle(
    color: Colors.black,
    // fontSize:20,
    // fontWeight: FontWeight.bold,
  );

  static const TextStyle _bodySmall = TextStyle(
    fontSize: 12,
  );
}
