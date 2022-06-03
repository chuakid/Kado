import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/screens/home_page.dart';
import 'package:kado/src/screens/widgets/card_list.dart';
import 'package:kado/src/screens/widgets/create/add_card.dart';
import 'package:kado/src/utils/helper.dart';

class StackPage extends GetView<UserController> {
  StackPage({Key? key}) : super(key: key);
  final RxString input = ''.obs;
  final RxBool isDarkMode =
      (HomePage.themeNotifier.value == ThemeMode.dark).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => buildToggleLightDarkModeButton(isDarkMode)),
            actions: [
              buildBackToHomeBtn(),
              buildProfileAvatar(controller.userModel),
              const SignOutButton()
            ]),
        body: const CardList(),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: addCard,
            onPressed: () {
              Get.defaultDialog(
                  title: addCard,
                  titleStyle: const TextStyle(fontSize: 15.0),
                  titlePadding: const EdgeInsets.only(top: 15.0),
                  content: AddCard(context: context),
                  contentPadding: const EdgeInsets.all(15.0),
                  radius: 10.0);
            }));
  }
}
