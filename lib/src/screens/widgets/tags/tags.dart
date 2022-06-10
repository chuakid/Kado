import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/widgets/tags/add_tag_form.dart';
import 'package:kado/src/screens/widgets/tags/tag.dart';

class Tags extends StatelessWidget {
  Tags({Key? key}) : super(key: key);
  final Rx<CardStack> cardStack = Get.find<StackController>().selectedStack;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0),
      decoration: const BoxDecoration(color: opaqueWhite),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Wrap(
              children:
                  cardStack.value.tags.map((i) => Tag(tagName: i)).toList())),
          addVerticalSpacing(10.0),
          const AddTagForm(),
        ],
      ),
    );
  }
}
