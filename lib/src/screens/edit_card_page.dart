import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/card_controller.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/utils/helper.dart';

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
                  card, cardName.value, frontContent.value, backContent.value)
              .then((_) {
            showSnackBar("Saved", cardName.value + " updated successfully.",
                SnackPosition.TOP);
            Navigator.of(context, rootNavigator: true).pop();
          });
        }
      }

      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel(
                          "Stack Name: ${stackController.selectedStack!.name}"),
                      addVerticalSpacing(10.0),
                      buildLabel("Card Name: ${card.name}"),
                      addVerticalSpacing(20.0),
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            TextFormField(
                              initialValue: card.name,
                              validator: (value) =>
                                  value != null && value.isEmpty
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
                              maxLines: 8,
                              validator: (value) =>
                                  value != null && value.isEmpty
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
                              maxLines: 8,
                              validator: (value) =>
                                  value != null && value.isEmpty
                                      ? "Enter back content"
                                      : null,
                              decoration: const InputDecoration(
                                labelText: 'Back Content',
                              ),
                              onChanged: (val) => backContent.value = val,
                              onFieldSubmitted: (_) => validateAndUpdateCard(),
                            ),
                            addVerticalSpacing(20.0),
                            buildActionBtn("Save", validateAndUpdateCard,
                                const Icon(Icons.save))
                          ]))
                    ]),
              )));
    }

    return Scaffold(
        appBar: AppBar(actions: [
          buildBackToHomeBtn(),
          buildProfileAvatar(),
          buildSignOutBtn(context)
        ]),
        body: PageView(
          controller:
              PageController(initialPage: cardController.selectedCardIdx),
          children: cardController.cards.map(_buildEditCardBody).toList(),
        ));
  }
}
