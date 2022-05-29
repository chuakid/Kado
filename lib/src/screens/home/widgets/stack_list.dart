import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/screens/home/stack_page.dart';

class StackList extends StatelessWidget {
  const StackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetX<UserController>(builder: (controller) {
        final stacks = controller.stacks;
        return GridView.builder(
            itemCount: stacks.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return Card(
                  child: InkWell(
                      onTap: () => Get.to(() => StackPage()),
                      child: Center(
                        child: Text(stacks[index].name),
                      )));
            });
      }),
    );
  }
}
