import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                validator: (value) => value == "" ? "Enter a tag" : null,
                autofocus: false,
                onChanged: (value) => {newTagName = value}),
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
