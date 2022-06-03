import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/utils/helper.dart';

class ViewCardPage extends GetView<UserController> {
  final EachCard card;
  ViewCardPage(this.card, {Key? key}) : super(key: key);
  final RxBool isFront = true.obs;

  @override
  Widget build(BuildContext context) {
    var txt = TextEditingController(text: card.frontContent);
    flipCard() {
      isFront.value = !isFront.value;
      txt.text = isFront.value ? card.frontContent : card.backContent;
    }

    return Scaffold(
      appBar: AppBar(actions: [
        buildProfileAvatar(controller.userModel),
        const SignOutButton()
      ]),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Card Name: ${card.name}",
                      style: const TextStyle(fontSize: 20.0)),
                  addHorizontalSpacing(20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(children: <Widget>[
                        TextField(
                          textAlign: TextAlign.center,
                          controller: txt,
                          readOnly: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: 25,
                          decoration: InputDecoration(
                            labelText:
                                '${isFront.value ? "Front" : "Back"} Content',
                          ),
                        ),
                        addHorizontalSpacing(20.0),
                        TextButton(
                            child: const Text("Flip",
                                style: TextStyle(fontSize: 15.0)),
                            onPressed: () => flipCard()),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
