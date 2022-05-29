import 'package:get/get.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/each_card.dart';
import 'package:kado/src/models/kado_user_model.dart';

class UserController extends GetxController {
  final KadoUserModel _userModel;
  RxList<CardStack> stacks = RxList<CardStack>([]);
  CardStack? selectedStack;
  RxList<EachCard>? cards;

  @override
  void onInit() {
    super.onInit();
    stacks.bindStream(DBService.getStacks());
  }

  UserController(this._userModel);

  KadoUserModel get userModel => _userModel;

  getCardsByStackId(String stackId) {
    cards!.bindStream(DBService.getCards(stackId));
  }

  CardStack? get getSelectedStack => selectedStack;

  set setSelectedStack(CardStack? selectedStack) =>
      this.selectedStack = selectedStack;
}
