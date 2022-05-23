import 'package:flutter/material.dart';
import 'package:kado/src/screens/home/user/user_details.dart';
import 'package:kado/src/utils/helper.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      userLoggedInPageOrGuestPage(const UserDetails());
}
