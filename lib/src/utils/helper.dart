import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/auth/auth_gate.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/home_page.dart';
import 'package:kado/src/screens/user_profile_page.dart';
import 'package:kado/src/screens/widgets/actions/add_tag.dart';
import 'package:kado/styles/palette.dart';
import 'package:kado/styles/theme.dart';

Widget buildSignOutBtn(BuildContext context) {
  FirebaseAuth? auth;

  return Container(
    margin: const EdgeInsets.only(right: appBarIconSpacing),
    child: IconButton(
        tooltip: "Sign Out",
        icon: const Icon(Icons.logout),
        onPressed: () {
          FlutterFireUIAuth.signOut(
            context: context,
            auth: auth,
          ).then((_) => Get.to(() => const AuthGate()));
        }),
  );
}

Widget buildBackToHomeBtn() => Container(
      margin: const EdgeInsets.only(right: appBarIconSpacing),
      child: IconButton(
          onPressed: () {
            Get.find<StackController>().getFilteredStacks();
            Get.off(() => HomePage());
          },
          icon: const Icon(Icons.home)),
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

Widget buildLabel(String text) => Container(
    padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
    decoration: const BoxDecoration(color: opaqueWhite),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: const TextStyle(fontSize: 20.0)),
      ],
    ));

void showSnackBar(String title, String subTitle, SnackPosition pos) =>
    Get.snackbar(title, subTitle,
        snackPosition: pos,
        backgroundColor: darkBlue,
        colorText: Colors.white,
        duration: const Duration(seconds: 1));

Widget buildActionBtn(String text, Function func, [Icon? icon]) {
  return icon == null
      ? OutlinedButton(
          onPressed: () => func(),
          child: Text(text),
        )
      : OutlinedButton.icon(
          onPressed: () => func(),
          icon: icon,
          label: Text(text),
        );
}

void addNewTag(List<String> tags) {
  Get.defaultDialog(
      title: addTag,
      titleStyle: dialogBoxTitleStyle,
      titlePadding: dialogBoxTitlePadding,
      content: AddTag(
        existingTags: tags,
      ),
      contentPadding: const EdgeInsets.all(15.0),
      radius: 10.0);
}
