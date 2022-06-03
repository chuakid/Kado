import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/screens/widgets/create/add_stack.dart';
import 'package:kado/src/screens/widgets/stack_list.dart';
import 'package:kado/src/utils/helper.dart';

class HomePage extends GetView<UserController> {
  HomePage({Key? key}) : super(key: key);

  final RxBool isDarkMode = (MyApp.themeNotifier.value == ThemeMode.dark).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => buildToggleLightDarkModeButton(isDarkMode)),
            actions: [
              buildProfileAvatar(controller.userModel),
              const SignOutButton()
            ]),
        body: StackList(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: addStack,
          onPressed: () => Get.defaultDialog(
            title: addStack,
            titleStyle: const TextStyle(fontSize: 15.0),
            titlePadding: const EdgeInsets.only(top: 15.0),
            content: AddStack(context: context),
            contentPadding: const EdgeInsets.all(15.0),
            radius: 10.0,
          ),
        ));
  }
}
