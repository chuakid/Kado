import 'package:cloud_firestore/cloud_firestore.dart';

class CardStack {
  String? text = '';
  String? id = '';

  CardStack(this.text, this.id);

  factory CardStack.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CardStack(data?['text'], data?['id']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (text != null) "text": text,
    };
  }
}
