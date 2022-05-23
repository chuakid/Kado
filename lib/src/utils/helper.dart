import 'package:flutter/material.dart';
import 'package:kado/src/auth/auth.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/guest_page.dart';
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

StreamBuilder userLoggedInPageOrGuestPage(Widget page) =>
    StreamBuilder<KadoUserModel?>(
      stream: AuthService.user,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const GuestPage();
        }
        return page;
      },
    );
