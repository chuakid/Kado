import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/home/widgets/kado_card.dart';

class CardList extends StatelessWidget {
  CardStack stack = Get.find<UserController>().selectedStack!;
  CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(builder: (controller) {
      return ListView(
          children: controller
              .getCardsByStackId(stack.id)
              .map((card) => KadoCard(card: card)));
    });
  }
}
