import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/styles/palette.dart';

class Tag extends GetView<StackController> {
  Tag({Key? key, required this.tagName, required this.selectedTags})
      : super(key: key);
  final String tagName;
  final List<String> selectedTags;
  final RxBool isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    void addTag() {
      selectedTags.add(tagName);
      isSelected.toggle();
    }

    return Obx(() => Container(
          margin: const EdgeInsets.all(5),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular((15.0))),
                color: isSelected.value ? darkRed : darkBlue),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: TextButton(
                onPressed: addTag,
                child:
                    Text(tagName, style: const TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ));
  }
}
