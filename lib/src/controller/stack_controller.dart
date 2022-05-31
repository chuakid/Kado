import 'package:get/get.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/each_card.dart';

class StackController extends GetxController with StateMixin {
  List<CardStack> stacks = [];
  CardStack? selectedStack;

  List<EachCard> getCardsByStackId(String stackId) {
    RxList<EachCard>? cards = RxList<EachCard>([]);
    cards.bindStream(DBService.getCards(stackId));
    return cards;
  }

  CardStack? get getSelectedStack => selectedStack;

  setSelectedStack(CardStack selectedStack) {
    this.selectedStack = selectedStack;
  }
}
