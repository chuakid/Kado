import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/screens/home/widgets/kado_card.dart';

class CardList extends GetView<StackController> {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CardStack stack = controller.selectedStack!;
    final List<EachCard> cardList = controller.getCardsByStackId(stack.id);
    return cardList.isEmpty
        ? const Text("No record found")
        : ListView(
            children: cardList.map((card) => KadoCard(card: card)).toList());
  }
}
