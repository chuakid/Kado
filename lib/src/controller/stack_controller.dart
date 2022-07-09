import 'package:get/get.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';

class StackController extends GetxController with StateMixin<List<CardStack>> {
  RxList<CardStack> stacks = <CardStack>[].obs;
  Rx<CardStack> selectedStack = CardStack('', '', '', [], true).obs;
  Rx<String> search = ''.obs;

  @override
  void onReady() {
    super.onReady();
    getFilteredStacks();
  }

  setSelectedStack(CardStack selectedStack) {
    this.selectedStack.value = selectedStack;
    this.selectedStack.bindStream(DBService.getStackById(selectedStack.id));
  }

  getFilteredStacks() {
    try {
      change(null, status: RxStatus.loading());
      DBService.getStacks().listen((cardStacks) {
        stacks.value = cardStacks;
        String queryLower = search.value.toLowerCase();
        var filtered = queryLower == ''
            ? cardStacks
            : cardStacks
                .where((stack) =>
                    stack.tags.contains(queryLower) ||
                    stack.name.toLowerCase().contains(queryLower))
                .toList();
        change(filtered, status: RxStatus.success());
      });
    } catch (exception) {
      change(null, status: RxStatus.error(exception.toString()));
    }
  }

  void deleteTag(String name) {
    DBService.deleteTag(selectedStack.value.id, name);
  }

  List<String> getTags() {
    return stacks.fold(
        [],
        (previousValue, element) =>
            (previousValue + element.tags).toSet().toList());
  }
}
