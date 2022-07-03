import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';

class SearchBar extends GetView<StackController> {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtController = TextEditingController(text: controller.search.value);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          controller: txtController,
          autocorrect: false,
          decoration: const InputDecoration(
              icon: Icon(Icons.search), hintText: searchHint),
          onChanged: (value) {
            controller.search.value = value;
            controller.getFilteredStacks();
          }),
    );
  }
}
