import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/utils/helper.dart';

class AddTag extends GetView<StackController> {
  AddTag({Key? key, required this.existingTags}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final List<String> existingTags;
  final RxString input = ''.obs;
  final RxBool isTagHidden = true.obs;
  final RxList<String> selectedTags = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    void validateAndAddTag() {
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        existingTags.add(input.value);
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            validator: (value) =>
                value != null && value.isEmpty ? emptyTagName : null,
            decoration: const InputDecoration(
              icon: Icon(Icons.bookmark),
              labelText: 'Tag Name',
              hintMaxLines: 1,
            ),
            onChanged: (val) => input.value = val,
            onFieldSubmitted: (value) => validateAndAddTag(),
          ),
          addVerticalSpacing(20.0),
          buildActionBtn("Add", validateAndAddTag, const Icon(Icons.add_box)),
        ]));
  }
}
