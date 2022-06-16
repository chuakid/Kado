import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/utils/helper.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final StackController stackController = Get.find<StackController>();
    final KadoUserModel user = userController.userModel;
    const double headerFontSize = 30.0;
    const double offsetFromCenter = -100.0;
    RxBool isDarkMode = (MyApp.themeNotifier.value == ThemeMode.dark).obs;

    const double imgSize = 150.0;
    final Widget img = user.photoURL.isEmpty
        ? CircleAvatar(
            radius: imgSize / 2,
            child: Center(
                child: Text(
              user.email!.substring(0, 1).toUpperCase(),
              style: const TextStyle(fontSize: 50),
            )))
        : Image.network(
            user.photoURL!,
            width: imgSize,
            height: imgSize,
          );

    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => buildToggleLightDarkModeButton(isDarkMode)),
            actions: [
              buildBackToHomeBtn(),
              const SignOutButton(),
            ]),
        body: Column(
          children: [
            addVerticalSpacing(50.0),
            Center(child: ClipOval(child: img)),
            addVerticalSpacing(20.0),
            Column(
              children: [
                Text(user.name,
                    style: const TextStyle(fontSize: headerFontSize)),
                Text(user.email,
                    style: const TextStyle(fontSize: headerFontSize / 2))
              ],
            ),
            addVerticalSpacing(30.0),
            Text("Number Of Decks: ${stackController.stacks.length}",
                style: const TextStyle(fontSize: 20.0))
          ],
        ));
  }
}
