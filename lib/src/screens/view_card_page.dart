import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/card_controller.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/utils/helper.dart';

class ViewCardPage extends GetView<CardController> {
  const ViewCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildViewFibCardBody(EachCard card) {
      var qnController = TextEditingController(text: card.frontContent);
      var ansController = TextEditingController();
      final RxBool isAnsDisplayed = false.obs;
      final RxString myAns = ''.obs;

      showAnswer() {
        isAnsDisplayed.toggle();
        ansController.text =
            isAnsDisplayed.value ? card.backContent : myAns.value;
      }

      return Container(
        padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(card.name),
                addVerticalSpacing(20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          textAlign: TextAlign.center,
                          controller: qnController,
                          readOnly: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          decoration:
                              const InputDecoration(labelText: "Question"),
                        ),
                        addVerticalSpacing(20.0),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: ansController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          readOnly: isAnsDisplayed.value,
                          onChanged: (val) => myAns.value = val,
                          decoration: InputDecoration(
                              labelText: isAnsDisplayed.value
                                  ? "Model Answer"
                                  : "Your Answer"),
                        ),
                        addVerticalSpacing(20.0),
                        buildActionBtn(
                            isAnsDisplayed.value
                                ? "Show My Answer"
                                : "Show Answer",
                            showAnswer,
                            null),
                      ]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildViewCardBody(EachCard card) {
      var txt = TextEditingController(text: card.frontContent);
      final RxBool isFront = true.obs;

      flipCard() {
        isFront.toggle();
        txt.text = isFront.value ? card.frontContent : card.backContent;
      }

      return Container(
        padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(card.name),
                addVerticalSpacing(20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          textAlign: TextAlign.center,
                          controller: txt,
                          readOnly: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: 20,
                          decoration: InputDecoration(
                            labelText:
                                '${isFront.value ? "Front" : "Back"} Content',
                          ),
                        ),
                        addVerticalSpacing(20.0),
                        buildActionBtn(
                            "Flip", flipCard, null, const Icon(Icons.flip)),
                      ]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(actions: [
          buildBackToHomeBtn(),
          buildProfileAvatar(),
          buildSignOutBtn(context)
        ]),
        body: PageView(
          controller: PageController(initialPage: controller.selectedCardIdx),
          children: controller.cards
              .map((card) => card.cardType == frontBack
                  ? buildViewCardBody(card)
                  : buildViewFibCardBody(card))
              .toList(),
        ));
  }
}
