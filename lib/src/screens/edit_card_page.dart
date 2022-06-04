import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/card_controller.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/palette.dart';

class EditCardPage extends StatelessWidget {
  EditCardPage({Key? key}) : super(key: key);
  final StackController stackController = Get.find<StackController>();
  final CardController cardController = Get.find<CardController>();

  @override
  Widget build(BuildContext context) {
    Widget _buildEditCardBody(EachCard card) {
      final RxString cardName = card.name.obs;
      final RxString frontContent = card.frontContent.obs;
      final RxString backContent = card.backContent.obs;
      final _formKey = GlobalKey<FormState>();

      void validateAndUpdateCard() async {
        FormState? fs = _formKey.currentState;
        if (fs != null && fs.validate()) {
          await DBService.updateCard(
              card, cardName.value, frontContent.value, backContent.value);
          Get.snackbar("Saved", cardName.value + " updated successfully.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: darkBlue,
              colorText: Colors.white);
          Get.back();
        }
      }

      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel(
                        "Stack Name: ${stackController.selectedStack!.name}"),
                    buildLabel("Card Name: ${card.name}"),
                    addVerticalSpacing(20.0),
                    Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          TextFormField(
                            initialValue: card.name,
                            validator: (value) => value != null && value.isEmpty
                                ? "Enter card name"
                                : null,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.card_membership),
                              labelText: 'Card Name',
                              hintMaxLines: 1,
                            ),
                            onChanged: (val) => cardName.value = val,
                            onFieldSubmitted: (_) => validateAndUpdateCard(),
                          ),
                          addVerticalSpacing(20.0),
                          TextFormField(
                            initialValue: card.frontContent,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            validator: (value) => value != null && value.isEmpty
                                ? "Enter front content"
                                : null,
                            decoration: const InputDecoration(
                              labelText: 'Front Content',
                            ),
                            onChanged: (val) => frontContent.value = val,
                            onFieldSubmitted: (_) => validateAndUpdateCard(),
                          ),
                          addVerticalSpacing(20.0),
                          TextFormField(
                            initialValue: card.backContent,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            validator: (value) => value != null && value.isEmpty
                                ? "Enter back content"
                                : null,
                            decoration: const InputDecoration(
                              labelText: 'Back Content',
                            ),
                            onChanged: (val) => backContent.value = val,
                            onFieldSubmitted: (_) => validateAndUpdateCard(),
                          ),
                          addVerticalSpacing(20.0),
                          TextButton(
                              child: const Text("Save",
                                  style: TextStyle(fontSize: 15.0)),
                              onPressed: () => validateAndUpdateCard()),
                        ]))
                  ]))));
    }

    return Scaffold(
        appBar: AppBar(actions: [
          buildBackToHomeBtn(),
          buildProfileAvatar(),
          const SignOutButton()
        ]),
        body: const Text("dhfaklsdjf")
        // _buildEditCardBody(
        //     cardController.cards[cardController.selectedCardIdx])
        // PageView(
        //   controller:
        //       PageController(initialPage: cardController.selectedCardIdx),
        //   children: cardController.cards.map(_buildEditCardBody).toList(),
        // )
        );
  }
}
