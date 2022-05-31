import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/home/stack_page.dart';
import 'package:kado/src/screens/misc/loader.dart';

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
          List<CardStack>? stacks = snapshot.data;
          controller.stacks = stacks!;
          return stacks.isEmpty
              ? const Center(
                  child: Text(
                    "No stacks record found",
                    style: TextStyle(fontSize: 25.0),
                  ),
                )
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
