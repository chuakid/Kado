import 'package:get/get.dart';
import 'package:kado/src/models/card_stack.dart';

class StackController extends GetxController with StateMixin {
  List<CardStack> stacks = [];
  CardStack? selectedStack;

  CardStack? get getSelectedStack => selectedStack;

  setSelectedStack(CardStack selectedStack) {
    this.selectedStack = selectedStack;
  }
}
