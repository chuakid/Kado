import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/screens/widgets/add_card_page.dart';
import 'package:kado/src/screens/widgets/card_list.dart';
import 'package:kado/src/utils/helper.dart';

class StackPage extends GetView<StackController> {
  StackPage({Key? key}) : super(key: key);
  final RxString input = ''.obs;
  final RxBool isDarkMode = (MyApp.themeNotifier.value == ThemeMode.dark).obs;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.15);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.30);

    void _showCardTypes() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: cardTypes.isEmpty ? 1 : cardTypes.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Column(
                      children: [
                        buildLabel(cardTypeSelect),
                        addVerticalSpacing(20.0),
                      ],
                    );
                  }
                  return ListTile(
                    key: Key("$i"),
                    title: Text(cardTypes[i - 1]),
                    tileColor: i.isEven ? evenItemColor : oddItemColor,
                    onTap: () =>
                        Get.to(() => AddCardPage(cardType: cardTypes[i - 1])),
                  );
                },
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => buildToggleLightDarkModeButton(isDarkMode)),
            actions: [
              buildBackToHomeBtn(),
              buildProfileAvatar(),
              buildSignOutBtn(context)
            ]),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CardList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: addCard,
            onPressed: () {
              _showCardTypes();
            }));
  }
}
