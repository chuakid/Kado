import 'package:flutter/material.dart';

class NoRecord extends StatelessWidget {
  final String _type;
  const NoRecord(this._type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No $_type record found",
        style: const TextStyle(fontSize: 25.0),
      ),
    );
  }
}
