import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';

class SearchBar extends GetView<StackController> {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtController = TextEditingController(text: controller.search.value);
    return TextField(
        controller: txtController,
        autocorrect: false,
        decoration: const InputDecoration(hintText: searchHint),
        onChanged: (value) {
          controller.search.value = value;
          controller.getFilteredStacks();
        });
  }
}
