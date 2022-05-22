import 'package:flutter/material.dart';
import 'package:kado/src/auth/auth.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/guest_page.dart';
import 'package:kado/src/screens/home/user/user_details.dart';

class UserProfilePage extends StatelessWidget {
  final KadoUserModel user;
  final Widget toggleThemeModeBtn;
  const UserProfilePage(
      {Key? key, required this.user, required this.toggleThemeModeBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double imgSize = 150.0;

    final Widget img = user.photoURL.isEmpty
        ? CircleAvatar(
            radius: imgSize / 2,
            child: Center(
                child: Text(
              user.email!.substring(0, 1).toUpperCase(),
              style: const TextStyle(fontSize: 50),
            )))
        : Image.network(
            user.photoURL!,
            width: imgSize,
            height: imgSize,
          );

    return StreamBuilder<KadoUserModel?>(
        stream: AuthService.user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const GuestPage();
          }
          return UserDetails(
              toggleThemeModeBtn: toggleThemeModeBtn, img: img, user: user);
        });
  }
}
