import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/screens/widgets/tag.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/palette.dart';

class EditStack extends StatelessWidget {
  final CardStack stack;
  EditStack({Key? key, required this.stack}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final RxBool isUpdating = false.obs;
  final RxBool isTagHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    final RxString stackName = stack.name.obs;
    RxList<String> currTags = stack.tags.obs;

    void validateAndUpdateStack() async {
      FormState? fs = _formKey.currentState;
      if (fs != null) {
        isUpdating.toggle();
        if (fs.validate()) {
          DBService.updateStack(stack.id, stackName.value, currTags).then((_) {
            showSnackBar(
                "Saved",
                "${stack.name} updated to ${stackName.value} successfully.",
                SnackPosition.BOTTOM);
            Navigator.of(context, rootNavigator: true).pop();
            isUpdating.toggle();
          });
        } else {
          isUpdating.toggle();
        }
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

    void deleteTag(String tagName) {
      currTags.remove(tagName);
    }

    return Obx(() => isUpdating.value
        ? const Loader()
        : Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                initialValue: stack.name,
                validator: (value) =>
                    value != null && value.isEmpty ? emptyStackName : null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  labelText: 'Stack Name',
                  hintMaxLines: 1,
                ),
                onChanged: (val) => stackName.value = val,
                onFieldSubmitted: (value) => validateAndUpdateStack(),
              ),
              addVerticalSpacing(20.0),
              buildActionBtn("${isTagHidden.value ? "Show" : "Hide"} Tags",
                  () => isTagHidden.toggle(), null),
              addVerticalSpacing(10.0),
              Visibility(
                  visible: !isTagHidden.value,
                  child: Container(
                    constraints:
                        const BoxConstraints(minHeight: 50, maxHeight: 100),
                    child: SingleChildScrollView(
                      child: Wrap(children: [
                        for (int i = 0; i < currTags.length + 1; i++)
                          i == currTags.length
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      18.0, 5.0, 0, 0),
                                  child: IconButton(
                                      onPressed: () => addNewTag(currTags),
                                      icon: const Icon(Icons.add)),
                                )
                              : Tag(
                                  tagName: currTags[i],
                                  onPressed: deleteTag,
                                  icon: const Icon(Icons.delete_forever))
                      ]),
                    ),
                  )),
              addVerticalSpacing(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildActionBtn("Save", validateAndUpdateStack, null,
                      const Icon(Icons.save)),
                  addHorizontalSpacing(10.0),
                  buildActionBtn(
                      "Delete",
                      deleteStack,
                      ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(darkRed)),
                      const Icon(Icons.delete_forever)),
                ],
              )
            ])));
  }
}
