import 'package:flutter/material.dart';

class NoRecord extends StatelessWidget {
  const NoRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No record found",
        style: TextStyle(fontSize: 25.0),
      ),
    );
  }
}
