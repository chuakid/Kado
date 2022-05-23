import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/create_card_stack/create_card_stack.dart';
import 'package:kado/src/screens/home/my_page_view.dart';
import 'package:kado/src/screens/home/user/user_profile_page.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/theme.dart';

class HomePage extends StatefulWidget {
  final KadoUserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget buildProfileAvatar(KadoUserModel user) {
      const double avatarRadiusSize = 20.0;
      final Widget img = user.photoURL!.isEmpty
          ? Text(user.email!.substring(0, 1).toUpperCase())
          : Image.network(user.photoURL!);
      return Container(
        margin: const EdgeInsets.only(right: appBarIconSpacing),
        child: CircleAvatar(
            radius: avatarRadiusSize,
            child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                textStyle: const TextStyle(color: Colors.white),
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UserProfilePage()));
                    },
                    child: Center(child: img)))),
      );
    }

    return userLoggedInPageOrGuestPage(ValueListenableBuilder<ThemeMode>(
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
                      buildProfileAvatar(widget.user),
                      const SignOutButton()
                    ]),
                body: const MyPageView(),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  tooltip: 'Add new stack',
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CreateCardStack()))
                    //add new stack of cards
                  },
                ),
              ));
        }));
  }
}