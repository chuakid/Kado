import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kado/src/controller/stack_controller.dart';

class SearchBar extends GetView<StackController> {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        autocorrect: false,
        decoration:
            const InputDecoration(hintText: "Search stacks by tag or name"),
        onChanged: (value) {
          controller.getFilteredStacks();
          controller.search.value = value;
        });
  }
}
