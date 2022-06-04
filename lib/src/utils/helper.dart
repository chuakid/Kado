import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/home_page.dart';
import 'package:kado/src/screens/user_profile_page.dart';

Widget buildBackToHomeBtn() => Container(
      margin: const EdgeInsets.only(right: appBarIconSpacing),
      child: IconButton(
          onPressed: () => Get.off(HomePage()), icon: const Icon(Icons.home)),
    );

Widget buildToggleLightDarkModeButton(RxBool isDarkMode) => IconButton(
    icon: Icon(isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
    onPressed: () {
      isDarkMode.toggle();
      MyApp.themeNotifier.value =
          isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    });

Widget buildProfileAvatar() {
  KadoUserModel user = Get.find<UserController>().userModel;
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
