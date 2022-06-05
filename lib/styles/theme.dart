import 'package:flutter/material.dart';
import 'package:kado/styles/palette.dart';

final themeData = ThemeData(
  primarySwatch: Palette.color,
  outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  textStyle: const TextStyle(fontSize: 18.0),
  minimumSize: const Size(88, 50),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

const TextStyle dialogBoxTitleStyle = TextStyle(fontSize: 18.0);
const EdgeInsets dialogBoxTitlePadding = EdgeInsets.symmetric(vertical: 15.0);
