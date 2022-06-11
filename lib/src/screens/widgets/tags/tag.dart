import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/styles/palette.dart';

class Tag extends GetView<StackController> {
  Tag({Key? key, required this.tagName, required this.onPressed, this.icon})
      : super(key: key);
  final String tagName;
  final Function onPressed;
  final Icon? icon;
  final RxBool isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.all(5),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular((15.0))),
                color: isSelected.value ? darkRed : darkBlue),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: () {
                  isSelected.toggle();
                  onPressed(tagName);
                },
                child: icon == null
                    ? Text(tagName, style: const TextStyle(color: Colors.white))
                    : Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(tagName,
                              style: const TextStyle(color: Colors.white)),
                          addHorizontalSpacing(10.0),
                          icon!,
                        ],
                      ),
              ),
            ),
          ),
        ));
  }
}
