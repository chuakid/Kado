import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/widgets/tags/add_tag_form.dart';
import 'package:kado/src/screens/widgets/tags/tag.dart';

class Tags extends StatelessWidget {
  Tags({Key? key}) : super(key: key);
  final Rx<CardStack> cardStack = Get.find<StackController>().selectedStack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Wrap(
            children:
                cardStack.value.tags.map((i) => Tag(tagName: i)).toList())),
        const AddTagForm(),
      ],
    );
  }
}
