import 'package:get/get.dart';
import 'package:kado/src/models/each_card.dart';

class CardController extends GetxController {
  List<EachCard> cards = [];
  int selectedCardIdx = 0;

  setSelectedCardIdx(int selectedCardIdx) =>
      this.selectedCardIdx = selectedCardIdx;

  EachCard getSelectedCard() => cards[selectedCardIdx];
}
