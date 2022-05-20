import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:kado/src/ui/screens/create_card_stack/create_card_stack.dart';
import 'package:kado/src/ui/widgets/my_page_view.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Logged in user details
    if (kDebugMode) {
      print(user);
    }
    String init =
        user.email == null ? "N" : user.email!.substring(0, 1).toUpperCase();
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(CupertinoIcons.trash),
          //   onPressed: () {},
          // ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(child: Text(init))),
            const SignOutButton(),
          ]),
      body: const MyPageView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add new stack',
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CreateCardStack()))
          //add new stack of cards
        },
      ),
      // TODO Create bottom nav
    );
  }
}
