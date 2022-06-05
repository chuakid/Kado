import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/misc/something_went_wrong.dart';
import 'package:kado/src/screens/stack_page.dart';
import 'package:kado/src/screens/widgets/actions/edit_stack.dart';
import 'package:kado/src/screens/widgets/no_record.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/styles/theme.dart';

class StackList extends StatelessWidget {
  StackList({Key? key}) : super(key: key);
  final controller = Get.put<StackController>(StackController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CardStack>>(
        stream: DBService.getStacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.hasError) {
            return const SomethingWentWrong();
          }
          List<CardStack> stacks = snapshot.data!;
          controller.stacks = stacks;
          return stacks.isEmpty
              ? const NoRecord("stack")
              : GridView.builder(
                  itemCount: stacks.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Card(
                        child: InkWell(
                            onLongPress: () => Get.defaultDialog(
                                  title: editStack,
                                  titleStyle: dialogBoxTitleStyle,
                                  titlePadding: dialogBoxTitlePadding,
                                  content: EditStack(stack: stacks[index]),
                                  contentPadding: const EdgeInsets.all(15.0),
                                  radius: 10.0,
                                ),
                            onTap: () {
                              controller.setSelectedStack(stacks[index]);
                              Get.to(() => StackPage());
                            },
                            child: Center(
                              child: Text(stacks[index].name),
                            )));
                  });
        });
  }
}
