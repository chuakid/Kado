import 'package:get/get.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';

class StackController extends GetxController with StateMixin {
  RxList<CardStack> stacks = <CardStack>[].obs;
  Rx<CardStack> selectedStack = CardStack('', '', '', []).obs;
  Rx<String> search = ''.obs;

  @override
  onInit() {
    stacks.bindStream(DBService.getStacks());
    super.onInit();
  }

  setSelectedStack(CardStack selectedStack) {
    this.selectedStack.bindStream(DBService.getStack(selectedStack.id));
  }

  List<CardStack> getFilteredStacks() {
    if (search.value == '') return stacks;
    return stacks
        .where((element) =>
            element.tags.contains(search.value) ||
            element.name.contains(search.value))
        .toList();
  }
}
