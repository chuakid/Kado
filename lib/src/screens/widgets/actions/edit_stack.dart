import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/utils/helper.dart';

class EditStack extends StatelessWidget {
  final CardStack stack;
  EditStack({Key? key, required this.stack}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final RxString stackName = ''.obs;
  final RxBool isUpdating = false.obs;

  @override
  Widget build(BuildContext context) {
    void validateAndUpdateStack() async {
      isUpdating.toggle();
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        DBService.updateStack(stack.id, stackName.value).then((_) {
          showSnackBar(
              "Saved",
              "${stack.name} updated to ${stackName.value} successfully.",
              SnackPosition.BOTTOM);
          Navigator.of(context, rootNavigator: true).pop();
          isUpdating.toggle();
        });
      }
    }

    void deleteStack() async {
      isUpdating.toggle();
      DBService.deleteStack(stack.id).then((_) {
        showSnackBar("Deleted", "${stack.name} deleted successfully.",
            SnackPosition.BOTTOM);
        Navigator.of(context, rootNavigator: true).pop();
        isUpdating.toggle();
      });
    }

    return Obx(() => isUpdating.value
        ? const Loader()
        : Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                initialValue: stack.name,
                validator: (value) =>
                    value != null && value.isEmpty ? "Enter stack name" : null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  labelText: 'Stack Name',
                  hintMaxLines: 1,
                ),
                onChanged: (val) => stackName.value = val,
                onFieldSubmitted: (value) => validateAndUpdateStack(),
              ),
              addVerticalSpacing(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildActionBtn(
                      "Save", validateAndUpdateStack, const Icon(Icons.save)),
                  addHorizontalSpacing(10.0),
                  buildActionBtn(
                      "Delete", deleteStack, const Icon(Icons.delete_forever)),
                  addHorizontalSpacing(10.0),
                  buildActionBtn("Close",
                      () => Navigator.of(context, rootNavigator: true).pop()),
                ],
              )
            ])));
  }
}
