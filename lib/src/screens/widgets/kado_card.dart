import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/card_controller.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/screens/view_card_page.dart';

class KadoCard extends GetView<CardController> {
  final EachCard card;
  final int cardIdx;
  const KadoCard({Key? key, required this.card, required this.cardIdx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10.0),
        child: ListTile(
            title: Text(card.name),
            onTap: () {
              controller.setSelectedCardIdx(cardIdx);
              Get.to(() => ViewCardPage());
            }));
  }
}
