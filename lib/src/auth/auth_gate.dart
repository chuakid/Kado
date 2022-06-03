import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/auth/auth.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/guest_page.dart';
import 'package:kado/src/screens/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<KadoUserModel?>(
      stream: AuthService.user,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const GuestPage();
        }
        return GetBuilder(
            init: UserController(snapshot.data!),
            builder: (_) => const HomePage());
      },
    );
  }
}
