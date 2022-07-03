import 'package:get/get.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';

class StackController extends GetxController with StateMixin<List<CardStack>> {
  RxList<CardStack> stacks = <CardStack>[].obs;
  Rx<CardStack> selectedStack = CardStack('', '', '', []).obs;
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
        var filtered = search.value == ''
            ? cardStacks
            : cardStacks
                .where((element) =>
                    element.tags.contains(search.value) ||
                    element.name.contains(search.value))
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
