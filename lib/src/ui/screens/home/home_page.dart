import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/ui/screens/create_card_stack/create_card_stack.dart';
import 'package:kado/src/ui/widgets/my_page_view.dart';
import 'package:kado/styles/theme.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    // Logged in user details
    if (kDebugMode) {
      print(user);
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
                    leading:
                        ToggleLightDarkModeButton(themeNotifier: themeNotifier),
                    actions: [
                      ProfileAvatar(user: user),
                      const SignOutButton(),
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
                // TODO Create bottom nav
              ));
        });
  }
}

class ProfileAvatar extends StatelessWidget {
  final User user;

  const ProfileAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarRadiusSize = 20.0;
    final Widget profileImg = user.photoURL == null
        ? CircleAvatar(
            radius: avatarRadiusSize,
            child: Text(user.email!.substring(0, 1).toUpperCase()))
        : CircleAvatar(
            radius: avatarRadiusSize,
            backgroundImage: NetworkImage(user.photoURL!),
          );

    return Container(
        margin: const EdgeInsets.only(right: 25.0),
        child: GestureDetector(onTap: () => print('tap'), child: profileImg));
  }
}

class ToggleLightDarkModeButton extends StatelessWidget {
  const ToggleLightDarkModeButton({
    Key? key,
    required this.themeNotifier,
  }) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(HomePage.themeNotifier.value == ThemeMode.light
            ? Icons.dark_mode
            : Icons.light_mode),
        onPressed: () {
          HomePage.themeNotifier.value =
              HomePage.themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
        });
  }
}
