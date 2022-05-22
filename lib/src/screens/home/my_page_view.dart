import 'package:flutter/material.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/models/Stack.dart';
import 'package:kado/src/provider/kado_user.dart';
import 'package:provider/provider.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  List<CardStack> stacks = [];

  @override
  void initState() {
    super.initState();
    DBService.getStacks().listen((event) {
      final List<CardStack> tempstacks = [];
      for (var doc in event.docs) {
        tempstacks.add(doc.data());
      }
      setState(() => stacks = tempstacks);
    });
  }

  @override
  Widget build(BuildContext context) {
    final KadoUserModel userModel = context.read<KadoUser>().getUserModel!;
    userModel.deckCount = stacks.length;
    context.read<KadoUser>().setUserModel(userModel);

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
