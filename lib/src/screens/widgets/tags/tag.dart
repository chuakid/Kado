import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';

class Tag extends GetView<StackController> {
  const Tag({Key? key, required this.tagName}) : super(key: key);
  final String tagName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: DecoratedBox(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular((20))),
            color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: TextButton(
            onPressed: () => controller.deleteTag(tagName),
            child: Text(tagName, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
