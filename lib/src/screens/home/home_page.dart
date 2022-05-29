import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/create_card_stack/create_card_stack.dart';
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
                    actions: [buildProfileAvatar(user), const SignOutButton()]),
                body: const StackList(),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    tooltip: 'Add new stack',
                    //add new stack of cards
                    onPressed: () => Get.to(() => const CreateCardStack())),
              ));
        });
  }
}
