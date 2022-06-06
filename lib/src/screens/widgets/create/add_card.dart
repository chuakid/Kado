import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/styles/palette.dart';

class AddCard extends GetView<StackController> {
  final BuildContext context;
  AddCard({Key? key, required this.context}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final RxString cardName = ''.obs;
  final RxString frontContent = ''.obs;
  final RxString backContent = ''.obs;

  @override
  Widget build(BuildContext context) {
    validateAndAddCard() {
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        DBService.addCard(controller.selectedStack.value.id, cardName.value,
            frontContent.value, backContent.value);
        Get.snackbar("New Card Added", cardName.value + " added successfully.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: darkBlue,
            colorText: Colors.white);
      }
    }

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            validator: (value) =>
                value != null && value.isEmpty ? "Enter card name" : null,
            decoration: const InputDecoration(
              icon: Icon(Icons.card_membership),
              labelText: 'Card Name',
              hintMaxLines: 1,
            ),
            onChanged: (val) => cardName.value = val,
            onFieldSubmitted: (_) => validateAndAddCard(),
          ),
          addHorizontalSpacing(20.0),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 8,
            validator: (value) =>
                value != null && value.isEmpty ? "Enter front content" : null,
            decoration: const InputDecoration(
              labelText: 'Front Content',
            ),
            onChanged: (val) => frontContent.value = val,
            onFieldSubmitted: (_) => validateAndAddCard(),
          ),
          addHorizontalSpacing(20.0),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 8,
            validator: (value) =>
                value != null && value.isEmpty ? "Enter back content" : null,
            decoration: const InputDecoration(
              labelText: 'Back Content',
            ),
            onChanged: (val) => backContent.value = val,
            onFieldSubmitted: (_) => validateAndAddCard(),
          ),
          addHorizontalSpacing(20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  child: const Text("Add", style: TextStyle(fontSize: 15.0)),
                  onPressed: () => validateAndAddCard()),
              TextButton(
                  child: const Text("Close", style: TextStyle(fontSize: 15.0)),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop())
            ],
          )
        ]));
  }
}
