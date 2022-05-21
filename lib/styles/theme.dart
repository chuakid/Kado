import 'package:flutter/material.dart';
import 'package:kado/styles/palette.dart';

final themeData = ThemeData(
  primarySwatch: Palette.color,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(24),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 20))),
  ),
);
