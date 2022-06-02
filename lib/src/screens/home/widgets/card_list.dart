import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/screens/home/widgets/kado_card.dart';
import 'package:kado/src/screens/home/widgets/no_record.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/utils/helper.dart';

class CardList extends GetView<StackController> {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CardStack stack = controller.selectedStack!;
    return StreamBuilder<List<EachCard>>(
        stream: DBService.getCards(stack.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.hasError) {
            return displayError("Error occurred while fetching data");
          }
          List<EachCard> cards = snapshot.data!;
          return cards.isEmpty
              ? const NoRecord()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                      children:
                          cards.map((card) => KadoCard(card: card)).toList()),
                );
        });
  }
}
