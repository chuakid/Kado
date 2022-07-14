import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/utils/helper.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final RxBool isDarkMode = (MyApp.themeNotifier.value == ThemeMode.dark).obs;

  void setNotifications(bool option) async {
    await DBService.updateUserReminder(option);
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final StackController stackController = Get.find<StackController>();

    final KadoUserModel user = userController.userModel;
    const double headerFontSize = 30.0;

    const double imgSize = 150.0;
    Widget buildImg() => CircleAvatar(
        radius: imgSize / 2,
        child: user.photoURL.isEmpty
            ? Obx(() => Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: isDarkMode.value ? Colors.grey[800] : Colors.transparent,
                textStyle: const TextStyle(color: Colors.white),
                child: Center(
                    child: Text(
                  user.email!.substring(0, 1).toUpperCase(),
                  style: const TextStyle(fontSize: 50),
                ))))
            : CircleAvatar(
                radius: imgSize / 2,
                backgroundImage: NetworkImage(user.photoURL)));

    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => buildToggleLightDarkModeButton(isDarkMode)),
            actions: [buildBackToHomeBtn(), buildSignOutBtn(context)]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              addVerticalSpacing(50.0),
              Center(child: ClipOval(child: buildImg())),
              addVerticalSpacing(20.0),
              Column(
                children: [
                  Text(user.name,
                      style: const TextStyle(fontSize: headerFontSize)),
                  Text(user.email,
                      style: const TextStyle(fontSize: headerFontSize / 2)),
                ],
              ),
              addVerticalSpacing(30.0),
              Text("Number Of Stacks: ${stackController.stacks.length}",
                  style: const TextStyle(fontSize: 20.0)),
              addVerticalSpacing(10.0),
              Obx(() => CheckboxListTile(
                  title: const Text('Set Hourly Reminder'),
                  value: userController.reminder.value,
                  onChanged: (value) => setNotifications(value!))),
            ],
          ),
        ));
  }
}
