import 'package:get/get.dart';
import 'package:kado/src/models/card_stack.dart';

class StackController extends GetxController {
  List<CardStack> stacks = [];
  CardStack? selectedStack;

  setSelectedStack(CardStack selectedStack) {
    this.selectedStack = selectedStack;
  }
}
