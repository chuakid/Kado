import 'package:get/get.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/models/kado_user_model.dart';

class UserController extends GetxController {
  final KadoUserModel _userModel;
  RxList<CardStack> stacks = RxList<CardStack>([]);
  CardStack? selectedStack;

  @override
  void onInit() {
    super.onInit();
    stacks.bindStream(DBService.getStacks());
  }

  UserController(this._userModel);

  KadoUserModel get userModel => _userModel;

  List<EachCard> getCardsByStackId(String stackId) {
    RxList<EachCard>? cards = RxList<EachCard>([]);
    cards.bindStream(DBService.getCards(stackId));
    return cards;
  }

  CardStack? get getSelectedStack => selectedStack;

  setSelectedStack(CardStack? selectedStack) =>
      this.selectedStack = selectedStack;
}
