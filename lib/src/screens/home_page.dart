import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/screens/widgets/actions/add_stack.dart';
import 'package:kado/src/screens/widgets/searchbar.dart';
import 'package:kado/src/screens/widgets/stack_list.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';

class HomePage extends GetView<StackController> {
  HomePage({Key? key}) : super(key: key);

  final RxBool isDarkMode = (MyApp.themeNotifier.value == ThemeMode.dark).obs;

  @override
  Widget build(BuildContext context) {
    Get.put<StackController>(StackController());

    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => buildToggleLightDarkModeButton(isDarkMode)),
            actions: [buildProfileAvatar(), buildSignOutBtn(context)]),
        body: Column(
          children: [
            const Searchbar(),
            addVerticalSpacing(20),
            const Expanded(child: StackList())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: addStack,
          onPressed: () => Get.defaultDialog(
            title: addStack,
            titleStyle: dialogBoxTitleStyle,
            titlePadding: dialogBoxTitlePadding,
            content: AddStack(context: context),
            contentPadding: const EdgeInsets.all(15.0),
            radius: 10.0,
          ),
        ));
  }
}
