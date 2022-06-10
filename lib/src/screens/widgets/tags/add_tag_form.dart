import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';

class AddTagForm extends StatefulWidget {
  const AddTagForm({Key? key}) : super(key: key);
  @override
  State<AddTagForm> createState() => _AddTagFormState();
}

class _AddTagFormState extends State<AddTagForm> {
  String newTagName = "";
  final _formKey = GlobalKey<FormState>();
  var controller = Get.find<StackController>();

  @override
  Widget build(BuildContext context) {
    FocusNode textNode = FocusNode();
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                focusNode: textNode,
                validator: (value) => value == "" ? "Enter a tag" : null,
                onChanged: (value) => {newTagName = value},
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(textNode);
                  DBService.addTagToStack(
                      controller.selectedStack.value.id, newTagName);
                }),
            addVerticalSpacing(10.0),
            OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10.0)),
                ),
                child: const Text(
                  "Add Tag",
                  textScaleFactor: 0.8,
                ),
                onPressed: () {
                  DBService.addTagToStack(
                      controller.selectedStack.value.id, newTagName);
                })
          ],
        ));
  }
}
