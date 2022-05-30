import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/screens/home/home_page.dart';
import 'package:kado/src/screens/home/widgets/card_list.dart';
import 'package:kado/src/screens/home/widgets/tags/tags.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';

class StackPage extends StatelessWidget {
  StackPage({Key? key}) : super(key: key);
  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: HomePage.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              title: title,
              theme: themeData,
              home: Scaffold(
                appBar:
                    AppBar(leading: buildToggleLightDarkModeButton(), actions: [
                  buildBackToHomeBtn(),
                  buildProfileAvatar(controller.userModel),
                  const SignOutButton()
                ]),
                body: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.selectedStack!.name),
                          Tags(),
                          const CardList(),
                        ])),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    tooltip: 'Add new card',
                    onPressed: () {}),
              ));
        });
  }
}
