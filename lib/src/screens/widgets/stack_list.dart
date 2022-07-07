import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/screens/misc/something_went_wrong.dart';
import 'package:kado/src/screens/stack_page.dart';
import 'package:kado/src/screens/widgets/actions/edit_stack.dart';
import 'package:kado/src/screens/widgets/no_record.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';

class StackList extends GetView<StackController> {
  const StackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildGridViewList(List<CardStack> stacks) {
      return GridView.builder(
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
    }

    return controller.obx((stacks) {
      if (stacks!.isEmpty) {
        return const NoRecord("stack");
      }
      List<CardStack> createdStacks =
          stacks.where((stack) => stack.isCreated).toList();
      List<CardStack> receivedStacks =
          stacks.where((stack) => !stack.isCreated).toList();
      return Column(
        children: [
          createdStacks.isNotEmpty
              ? Expanded(
                  child: Column(children: [
                  buildLabel("Created"),
                  addVerticalSpacing(5.0),
                  Expanded(child: buildGridViewList(createdStacks)),
                ]))
              : Container(),
          addVerticalSpacing(10.0),
          receivedStacks.isNotEmpty
              ? Expanded(
                  child: Column(children: [
                  buildLabel("Received"),
                  addVerticalSpacing(5.0),
                  Expanded(child: buildGridViewList(receivedStacks))
                ]))
              : Container(),
        ],
      );
    }, onLoading: const Loader(), onError: (_) => const SomethingWentWrong());
  }
}
