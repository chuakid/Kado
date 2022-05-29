import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/home/home_page.dart';
import 'package:kado/src/screens/home/user/user_profile_page.dart';

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

Widget buildProfileAvatar(KadoUserModel user) {
  const double avatarRadiusSize = 20.0;
  final Widget img = user.photoURL!.isEmpty
      ? Text(user.email!.substring(0, 1).toUpperCase())
      : Image.network(user.photoURL!);
  return Container(
    margin: const EdgeInsets.only(right: appBarIconSpacing),
    child: CircleAvatar(
        radius: avatarRadiusSize,
        child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            textStyle: const TextStyle(color: Colors.white),
            child: InkWell(
                onTap: () => Get.to(() => const UserProfilePage()),
                child: Center(child: img)))),
  );
}
