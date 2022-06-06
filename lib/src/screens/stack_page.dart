import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/home_page.dart';
import 'package:kado/src/screens/widgets/card_list.dart';
import 'package:kado/src/screens/widgets/create/add_card.dart';
import 'package:kado/src/screens/widgets/tags/tags.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';

class StackPage extends StatelessWidget {
  StackPage({Key? key}) : super(key: key);
  final KadoUserModel user = Get.find<UserController>().userModel;
  final RxString input = ''.obs;

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
                  appBar: AppBar(
                      leading: buildToggleLightDarkModeButton(),
                      actions: [
                        buildBackToHomeBtn(),
                        buildProfileAvatar(user),
                        const SignOutButton()
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
                            titleStyle: const TextStyle(fontSize: 15.0),
                            titlePadding: const EdgeInsets.only(top: 15.0),
                            content: AddCard(context: context),
                            contentPadding: const EdgeInsets.all(15.0),
                            radius: 10.0);
                      })));
        });
  }
}
