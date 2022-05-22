import 'package:flutter/cupertino.dart';
import 'package:kado/src/models/kado_user_model.dart';

class KadoUser extends ChangeNotifier {
  KadoUserModel? _userModel;

  KadoUserModel? get getUserModel => _userModel;

  setUserModel(KadoUserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}
