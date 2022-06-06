import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/screens/stack_page.dart';
import 'package:kado/src/screens/widgets/no_record.dart';

class StackList extends StatelessWidget {
  const StackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<StackController>(builder: (controller) {
      var stacks = controller.getFilteredStacks();
      return stacks.isEmpty
          ? const NoRecord()
          : GridView.builder(
              itemCount: stacks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Card(
                    child: InkWell(
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
