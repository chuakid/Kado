import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/screens/widgets/actions/add_card.dart';
import 'package:kado/src/screens/widgets/card_list.dart';
import 'package:kado/src/screens/widgets/tags/tags.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';

class StackPage extends GetView<StackController> {
  StackPage({Key? key}) : super(key: key);
  final RxString input = ''.obs;
  final RxBool isDarkMode = (MyApp.themeNotifier.value == ThemeMode.dark).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => buildToggleLightDarkModeButton(isDarkMode)),
            actions: [
              buildBackToHomeBtn(),
              buildProfileAvatar(),
              buildSignOutBtn(context)
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Tags(),
            const Expanded(
              child: CardList(),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: addCard,
            onPressed: () {
              Get.defaultDialog(
                  title: addCard,
                  titleStyle: dialogBoxTitleStyle,
                  titlePadding: dialogBoxTitlePadding,
                  content: AddCard(context: context),
                  contentPadding: const EdgeInsets.all(15.0),
                  radius: 10.0);
            }));
  }
}
