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
  final RxString input = ''.obs;

  @override
  Widget build(BuildContext context) {
    validateAndAddCard() {
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        DBService.addCard(controller.getSelectedStack!.id, input.value);
        Get.snackbar("New Card Added", input.value + " added successfully.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: darkBlue,
            colorText: Colors.white);
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            validator: (value) =>
                value != null && value.isEmpty ? "Enter card name" : null,
            decoration: const InputDecoration(
              icon: Icon(Icons.book),
              labelText: 'Card Name',
              hintMaxLines: 1,
            ),
            onChanged: (val) => input.value = val,
            onFieldSubmitted: (value) => validateAndAddCard(),
          ),
          addHorizontalSpacing(20.0),
          TextButton(
              child: const Text("Add", style: TextStyle(fontSize: 15.0)),
              onPressed: () => validateAndAddCard())
        ]));
  }
}
