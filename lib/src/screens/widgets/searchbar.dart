import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kado/src/controller/stack_controller.dart';

class Searchbar extends GetView<StackController> {
  const Searchbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      decoration:
          const InputDecoration(hintText: "Search stacks by tag or name"),
      onChanged: (value) => controller.search.value = value,
    );
  }
}
