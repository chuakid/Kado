import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Something went wrong!',
          style: TextStyle(color: Colors.grey),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
