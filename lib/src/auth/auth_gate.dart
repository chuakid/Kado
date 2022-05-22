import 'package:flutter/material.dart';
import 'package:kado/src/auth/auth.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/provider/kado_user.dart';
import 'package:kado/src/screens/guest_page.dart';
import 'package:kado/src/screens/home/home_page.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  KadoUserModel buildUserModel(BuildContext context, AsyncSnapshot snapshot) {
    final KadoUserModel userModel = snapshot.data!;
    context.read<KadoUser>().setUserModel(userModel);
    return context.watch<KadoUser>().getUserModel!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<KadoUserModel?>(
      stream: AuthService.user,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const GuestPage();
        }
        return HomePage(user: buildUserModel(context, snapshot));
      },
    );
  }
}
