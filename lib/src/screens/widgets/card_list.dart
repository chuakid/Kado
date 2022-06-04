import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/card_controller.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/screens/edit_card_page.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/screens/misc/something_went_wrong.dart';
import 'package:kado/src/screens/view_card_page.dart';
import 'package:kado/src/screens/widgets/no_record.dart';
import 'package:kado/src/utils/helper.dart';

class CardList extends GetView<StackController> {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.15);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.30);

    return StreamBuilder<List<EachCard>>(
        stream: DBService.getCards(controller.selectedStack!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.hasError) {
            return const SomethingWentWrong();
          }
          final RxList<EachCard> cards = snapshot.data!.obs;
          final CardController cardController =
              Get.put<CardController>(CardController());
          cardController.cards = cards;

          void deleteCard(int i) async {
            await DBService.deleteCard(cards[i]);
            cards.removeAt(i);
          }

          return cards.isEmpty
              ? const NoRecord("card")
              : Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: buildLabel(controller.selectedStack!.name)),
                    addVerticalSpacing(10.0),
                    Expanded(
                      child: Obx(() => ReorderableListView(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0),
                            children: [
                              for (int i = 0; i < cards.length; i++)
                                ListTile(
                                    key: Key('$i'),
                                    title: Text(cards[i].name),
                                    tileColor:
                                        i.isEven ? evenItemColor : oddItemColor,
                                    trailing: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Wrap(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                cardController
                                                    .setSelectedCardIdx(i);
                                                Get.to(() => EditCardPage());
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () => deleteCard(i),
                                              icon: const Icon(Icons.delete)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      cardController.setSelectedCardIdx(i);
                                      Get.to(() => ViewCardPage());
                                    })
                            ],
                            onReorder: (int oldIndex, int newIndex) {
                              if (oldIndex < newIndex) {
                                newIndex--;
                              }
                              final EachCard card = cards.removeAt(oldIndex);
                              cards.insert(newIndex, card);
                            },
                          )),
                    ),
                  ],
                );
        });
  }
}
