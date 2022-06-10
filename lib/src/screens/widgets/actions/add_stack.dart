import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/utils/helper.dart';

class AddStack extends StatelessWidget {
  final BuildContext context;
  AddStack({Key? key, required this.context}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final RxString input = ''.obs;
  final RxBool isAdding = false.obs;

  @override
  Widget build(BuildContext context) {
    validateAndAddStack() {
      isAdding.toggle();
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        DBService.addStack(input.value).then((_) {
          showSnackBar("New Stack Added", input.value + " added successfully.",
              SnackPosition.TOP);
          Navigator.of(context, rootNavigator: true).pop();
          isAdding.toggle();
        });
      }
    }

    return Obx(() => isAdding.value
        ? const Loader()
        : Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                validator: (value) =>
                    value != null && value.isEmpty ? "Enter stack name" : null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  labelText: 'Stack Name',
                  hintMaxLines: 1,
                ),
                onChanged: (val) => input.value = val,
                onFieldSubmitted: (value) => validateAndAddStack(),
              ),
              addVerticalSpacing(20.0),
              buildActionBtn(
                  "Add", validateAndAddStack, const Icon(Icons.add_box)),
            ])));
  }
}
