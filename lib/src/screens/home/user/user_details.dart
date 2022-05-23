import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/provider/kado_user.dart';
import 'package:kado/src/screens/home/home_page.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final KadoUserModel user = context.read<KadoUser>().getUserModel!;
    const double headerFontSize = 30.0;
    const double offsetFromCenter = -100.0;

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

    Widget buildBackToHomeBtn() {
      return Container(
        margin: const EdgeInsets.only(right: appBarIconSpacing),
        child: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => HomePage(user: user))),
            icon: const Icon(Icons.home)),
      );
    }

    return ValueListenableBuilder<ThemeMode>(
        valueListenable: HomePage.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              title: title,
              theme: themeData,
              home: Scaffold(
                  appBar: AppBar(
                      leading: buildToggleLightDarkModeButton(),
                      actions: [
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
                              style:
                                  const TextStyle(fontSize: headerFontSize / 2))
                        ],
                      ),
                      addHorizontalSpacing(30.0),
                      Transform.translate(
                        offset: const Offset(offsetFromCenter, 0),
                        child: Text("Number Of Decks: ${user.deckCount}",
                            style: const TextStyle(fontSize: 20.0)),
                      )
                    ],
                  )));
        });
  }
}
