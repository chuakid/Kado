import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      headerBuilder: (context, constraints, _) {
        return Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Image.asset(
            'images/logo.jpg',
            scale: 0.6,
          ),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            action == AuthAction.signIn
                ? 'Welcome to Kado! Please sign in to continue.'
                : 'Welcome to Kado! Please create an account to continue',
          ),
        );
      },
      footerBuilder: (context, _) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'By signing in, you agree to our terms and conditions.',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
      providerConfigs: const [
        EmailProviderConfiguration(),
        GoogleProviderConfiguration(
            clientId:
                "72886769722-ccvoqo46db8affvr23m6gkanltqmeeh0.apps.googleusercontent.com")
      ],
    );
  }
}
