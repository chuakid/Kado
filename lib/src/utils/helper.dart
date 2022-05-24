import 'package:flutter/material.dart';
import 'package:kado/src/screens/home/home_page.dart';

Widget buildToggleLightDarkModeButton() => IconButton(
    icon: Icon(HomePage.themeNotifier.value == ThemeMode.light
        ? Icons.dark_mode
        : Icons.light_mode),
    onPressed: () {
      HomePage.themeNotifier.value =
          HomePage.themeNotifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light;
    });
