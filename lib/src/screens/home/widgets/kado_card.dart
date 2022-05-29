import 'package:flutter/material.dart';
import 'package:kado/src/models/each_card.dart';

class KadoCard extends StatelessWidget {
  final EachCard card;
  const KadoCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 16.0),
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[500],
            ),
            title: Text(card.name),
            subtitle: const Text("Card subtitle")));
  }
}
