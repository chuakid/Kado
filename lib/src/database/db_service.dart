import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kado/src/models/Stack.dart';

class DBService {
  static final db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future addStack(String stackName) {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("uid empty");
    }

    return db.collection("stacks").add({"uid": uid, "text": stackName});
  }

  static Future addCard(String stackId, String text) {
    return db
        .collection("stacks")
        .doc(stackId)
        .collection("cards")
        .add({"name": text});
  }

  static Stream getStacks() {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("uid empty");
    }
    return db
        .collection("stacks")
        .where("uid", isEqualTo: uid)
        .withConverter(
            fromFirestore: CardStack.fromFirestore,
            toFirestore: (CardStack cardStack, _) => cardStack.toFirestore())
        .snapshots();
    // return db.collection("stacks").where("uid", isEqualTo: uid).snapshots();
  }
}
