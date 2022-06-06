import 'package:get/get.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';

class StackController extends GetxController with StateMixin {
  List<CardStack> stacks = [];
  Rx<CardStack> selectedStack = CardStack('', '', '', []).obs;
  Rx<String> search = ''.obs;

  setSelectedStack(CardStack selectedStack) {
    this.selectedStack.bindStream(DBService.getStack(selectedStack.id));
  }
}
