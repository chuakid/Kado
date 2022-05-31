import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/screens/home/widgets/tags/add_tag_form.dart';
import 'package:kado/src/screens/home/widgets/tags/tag.dart';

class Tags extends GetView<StackController> {
  const Tags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
            children: controller.selectedStack!.tags
                .map((i) => Tag(tagName: i))
                .toList()),
        const AddTagForm(),
      ],
    );
  }
}
