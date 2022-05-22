import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/home/home_page.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.toggleThemeModeBtn,
    required this.img,
    required this.user,
  }) : super(key: key);

  final Widget toggleThemeModeBtn;
  final Widget img;
  final KadoUserModel user;

  @override
  Widget build(BuildContext context) {
    const double headerFontSize = 30.0;
    const double offsetFromCenter = -100.0;

    Widget buildBackToHomeBtn() {
      return Container(
        margin: const EdgeInsets.only(right: appBarIconSpacing),
        child: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => HomePage(user: user))),
            icon: const Icon(Icons.home)),
      );
    }

    return Scaffold(
        appBar: AppBar(leading: toggleThemeModeBtn, actions: [
          buildBackToHomeBtn(),
          const SignOutButton(),
        ]),
        body: Column(
          children: [
            addHorizontalSpacing(50.0),
            Center(child: ClipOval(child: img)),
            addHorizontalSpacing(20.0),
            Column(
              children: [
                Text(user.name,
                    style: const TextStyle(fontSize: headerFontSize)),
                Text(user.email,
                    style: const TextStyle(fontSize: headerFontSize / 2))
              ],
            ),
            addHorizontalSpacing(30.0),
            Transform.translate(
              offset: const Offset(offsetFromCenter, 0),
              child: Text("Number Of Decks: ${user.deckCount}",
                  style: const TextStyle(fontSize: 20.0)),
            )
          ],
        ));
  }
}
