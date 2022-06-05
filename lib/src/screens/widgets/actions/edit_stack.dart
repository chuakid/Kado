import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/utils/helper.dart';

class EditStack extends StatelessWidget {
  final CardStack stack;
  EditStack({Key? key, required this.stack}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final RxString stackName = ''.obs;

  @override
  Widget build(BuildContext context) {
    void validateAndUpdateStack() async {
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        await DBService.updateStack(stack.id, stackName.value);
        showSnackBar("Saved", stackName.value + " updated successfully.",
            SnackPosition.BOTTOM);
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    void deleteStack() async {
      await DBService.deleteStack(stack.id);
      Navigator.of(context, rootNavigator: true).pop();
    }

    return Form(
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
        ]));
  }
}
