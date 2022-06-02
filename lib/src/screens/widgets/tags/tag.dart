import 'package:flutter/cupertino.dart';

class Tag extends StatelessWidget {
  const Tag({Key? key, required this.tagName}) : super(key: key);
  final String tagName;
  @override
  Widget build(BuildContext context) {
    return Text(tagName);
  }
}
