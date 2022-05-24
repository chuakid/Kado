import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/user.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/models/Stack.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
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
    return GridView.builder(
        itemCount: stacks.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Card(
              child: InkWell(
                  onTap: () => {debugPrint("tapped")},
                  child: Text(
                      stacks[index].text != null ? stacks[index].text! : "")));
        });
  }
}
