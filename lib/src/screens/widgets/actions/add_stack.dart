import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/screens/widgets/tags/tag.dart';
import 'package:kado/src/utils/helper.dart';

class AddStack extends GetView<StackController> {
  AddStack({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final RxString input = ''.obs;
  final RxBool isAdding = false.obs;
  final RxBool isTagHidden = true.obs;
  final RxList<String> selectedTags = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    final RxList<String> existingTags = controller.getTags().obs;

    void validateAndAddStack() {
      FormState? fs = _formKey.currentState;
      if (fs != null) {
        isAdding.toggle();
        if (fs.validate()) {
          DBService.addStack(input.value, selectedTags).then((_) {
            showSnackBar("New Stack Added",
                input.value + " added successfully.", SnackPosition.TOP);
            Navigator.of(context, rootNavigator: true).pop();
            isAdding.toggle();
          });
        } else {
          isAdding.toggle();
        }
      }
    }

    void addTag(String tagName) {
      selectedTags.add(tagName);
    }

    return Obx(() => isAdding.value
        ? const Loader()
        : Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                validator: (value) =>
                    value != null && value.isEmpty ? emptyStackName : null,
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
                  "${isTagHidden.value ? "Select From" : "Hide"} Existing Tags",
                  () => isTagHidden.toggle()),
              addVerticalSpacing(10.0),
              Visibility(
                  visible: !isTagHidden.value,
                  child: Wrap(children: [
                    for (int i = 0; i < existingTags.length + 1; i++)
                      i == existingTags.length
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(18.0, 5.0, 0, 0),
                              child: IconButton(
                                  onPressed: () => addNewTag(existingTags),
                                  icon: const Icon(Icons.add)),
                            )
                          : Tag(
                              tagName: existingTags[i],
                              onPressed: addTag,
                            )
                  ])),
              addVerticalSpacing(20.0),
              buildActionBtn(
                  "Add", validateAndAddStack, const Icon(Icons.add_box)),
            ])));
  }
}
