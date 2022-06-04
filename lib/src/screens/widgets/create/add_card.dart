import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/utils/helper.dart';

class AddCard extends GetView<StackController> {
  final BuildContext context;
  AddCard({Key? key, required this.context}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final RxString cardName = ''.obs;
  final RxString frontContent = ''.obs;
  final RxString backContent = ''.obs;
  final _cardNameController = TextEditingController();
  final _frontContentController = TextEditingController();
  final _backContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void resetAllFields() {
      _cardNameController.clear();
      _frontContentController.clear();
      _backContentController.clear();
    }

    void validateAndAddCard() {
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        DBService.addCard(controller.selectedStack!.id, cardName.value,
            frontContent.value, backContent.value);
        showSnackBar("New Card Added", cardName.value + " added successfully.",
            SnackPosition.TOP);
        resetAllFields();
      }
    }

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            controller: _cardNameController,
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
          addVerticalSpacing(20.0),
          TextFormField(
            controller: _frontContentController,
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
          addVerticalSpacing(20.0),
          TextFormField(
            controller: _backContentController,
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
          addVerticalSpacing(20.0),
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
