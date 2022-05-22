import 'package:firebase_auth/firebase_auth.dart';
import 'package:kado/src/models/kado_user_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static KadoUserModel? _userFromFirebase(User? user) {
    if (user != null) {
      final String photoURL = user.photoURL ?? '';
      final String userName = user.displayName == null
          ? user.email!.split('@')[0]
          : user.displayName!;
      return KadoUserModel(userName, user.email!, photoURL);
    }
    return null;
  }

  static Stream<KadoUserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }
}
