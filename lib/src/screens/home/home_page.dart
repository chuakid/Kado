import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/create/add_stack.dart';
import 'package:kado/src/screens/home/widgets/stack_list.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  final KadoUserModel user = Get.find<UserController>().userModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: HomePage.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              title: title,
              theme: themeData,
              home: Scaffold(
                  appBar: AppBar(
                      leading: buildToggleLightDarkModeButton(),
                      actions: [
                        buildProfileAvatar(user),
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
                  )));
        });
  }
}
