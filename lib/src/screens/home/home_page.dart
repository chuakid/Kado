import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/models/kado_user_model.dart';
import 'package:kado/src/screens/create_card_stack/create_card_stack.dart';
import 'package:kado/src/screens/home/my_page_view.dart';
import 'package:kado/src/screens/home/user/user_profile_page.dart';
import 'package:kado/styles/theme.dart';

class HomePage extends StatelessWidget {
  final KadoUserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    Widget buildToggleLightDarkModeButton(
            ValueNotifier<ThemeMode> themeNotifier) =>
        IconButton(
            icon: Icon(HomePage.themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              HomePage.themeNotifier.value =
                  HomePage.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            });

    final Widget toggleThemeModeBtn =
        buildToggleLightDarkModeButton(themeNotifier);

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
                              builder: (_) => UserProfilePage(
                                  user: user,
                                  toggleThemeModeBtn: toggleThemeModeBtn)));
                    },
                    child: Center(child: img)))),
      );
    }

    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              title: title,
              theme: themeData,
              home: Scaffold(
                appBar: AppBar(
                    leading: toggleThemeModeBtn,
                    actions: [buildProfileAvatar(user), const SignOutButton()]),
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
                // TODO: Create bottom nav
              ));
        });
  }
}
