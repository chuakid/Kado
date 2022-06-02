import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/screens/view_card_page.dart';

class KadoCard extends StatelessWidget {
  final EachCard card;
  const KadoCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10.0),
        child: ListTile(
            title: Text(card.name), onTap: () => Get.to(ViewCardPage(card))));
  }
}
