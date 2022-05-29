import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/kado_user_model.dart';

class StackList extends StatefulWidget {
  const StackList({Key? key}) : super(key: key);

  @override
  State<StackList> createState() => _StackListState();
}

class _StackListState extends State<StackList> {
  List<CardStack> stacks = [];
  final KadoUserModel userModel = Get.find<UserController>().userModel;

  @override
  void initState() {
    super.initState();
    DBService.getStacks().listen((event) {
      final List<CardStack> tempstacks = [];
      for (var doc in event.docs) {
        tempstacks.add(doc.data());
      }
      setState(() {
        stacks = tempstacks;
        userModel.deckCount = stacks.length;
        Get.find<UserController>().setUserModel(userModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: stacks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Card(
                child: InkWell(
                    onTap: () => {debugPrint("tapped")},
                    child: Center(
                      child: Text(stacks[index].text != null
                          ? stacks[index].text!
                          : ""),
                    )));
          }),
    );
  }
}
