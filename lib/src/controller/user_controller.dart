import 'package:get/get.dart';
import 'package:kado/src/models/kado_user_model.dart';

class UserController extends GetxController {
  final KadoUserModel _userModel;

  UserController(this._userModel);

  KadoUserModel get userModel => _userModel;
}
