import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/card_controller.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/utils/helper.dart';

class ViewCardPage extends StatelessWidget {
  ViewCardPage({Key? key}) : super(key: key);
  final CardController cardController = Get.find<CardController>();
  final RxBool isFront = true.obs;

  @override
  Widget build(BuildContext context) {
    Widget _buildViewCardBody(EachCard card) {
      var txt = TextEditingController(text: card.frontContent);

      flipCard() {
        isFront.value = !isFront.value;
        txt.text = isFront.value ? card.frontContent : card.backContent;
      }

      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel("Card Name: ${card.name}"),
                  addVerticalSpacing(20.0),
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
                        addVerticalSpacing(20.0),
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
          ));
    }

    return Scaffold(
        appBar: AppBar(actions: [
          buildBackToHomeBtn(),
          buildProfileAvatar(),
          const SignOutButton()
        ]),
        body: PageView(
          controller:
              PageController(initialPage: cardController.selectedCardIdx),
          children: cardController.cards.map(_buildViewCardBody).toList(),
        ));
  }
}
