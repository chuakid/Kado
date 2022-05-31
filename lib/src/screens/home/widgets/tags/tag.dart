import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tag extends StatelessWidget {
  const Tag({Key? key, required this.tagName}) : super(key: key);
  final String tagName;
  @override
  Widget build(BuildContext context) {
    return Text(tagName);
  }
}
