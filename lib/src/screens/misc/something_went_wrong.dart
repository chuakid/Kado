import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Something went wrong while fetching data!',
          style: TextStyle(color: Colors.red),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
