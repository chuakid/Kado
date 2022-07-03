import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/each_card.dart';

class DBService {
  static final db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static const String stackCollectionName = "stacks";
  static const String cardCollectionName = "cards";
  static const String userCollectionName = "user_suggestion";
  static final stacksCollectionRef = db.collection(stackCollectionName);
  static final usersCollectionRef = db.collection(userCollectionName);

  // Create operations
  static Future<void> addStack(String name, List<String> tags) {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("uid empty");
    }

    return stacksCollectionRef.add({"uid": uid, "name": name, "tags": tags});
  }

  static Future addCard(String stackId, String name, String frontContent,
      String backContent, String cardType) {
    return stacksCollectionRef.doc(stackId).collection(cardCollectionName).add({
      "name": name,
      "frontContent": frontContent,
      "backContent": backContent,
      "cardType": cardType
    });
  }

  // Read Operations
  static Stream<List<CardStack>> getStacks() {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("uid empty");
    }
    return stacksCollectionRef
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map(_cardStackListFromSnapshot);
  }

  static List<CardStack> _cardStackListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> asMap = doc.data() as Map<String, dynamic>;
      return CardStack(doc.id, doc['name'], doc['uid'],
          asMap.containsKey('tags') ? List<String>.from(doc['tags']) : []);
    }).toList();
  }

  static Stream<CardStack> getStackById(String stackId) {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("uid empty");
    }
    return stacksCollectionRef.doc(stackId).snapshots().map(
      (doc) {
        Map<String, dynamic> asMap = doc.data() as Map<String, dynamic>;
        return CardStack(doc.id, doc['name'], doc['uid'],
            asMap.containsKey('tags') ? List<String>.from(doc['tags']) : []);
      },
    );
  }

  static Stream<List<EachCard>> getCards(String stackId) {
    final cardsCollectionRef =
        stacksCollectionRef.doc(stackId).collection(cardCollectionName);

    return cardsCollectionRef
        .snapshots()
        .map((ss) => _eachCardListFromSnapshot(ss, stackId));
  }

  static List<EachCard> _eachCardListFromSnapshot(
      QuerySnapshot snapshot, String stackId) {
    return snapshot.docs
        .map((doc) => EachCard(doc.id, stackId, doc['name'],
            doc['frontContent'], doc['backContent'], doc['cardType']))
        .toList();
  }

  static Future<List<String>> getUserSuggestions(String query) {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("uid empty");
    }

    Stream<List<String>> emails = usersCollectionRef
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((ss) => _kadoUserModelListFromSnapshot(ss, query));

    return emails.firstWhere((event) => true);
  }

  static List<String> _kadoUserModelListFromSnapshot(
      QuerySnapshot snapshot, String query) {
    QueryDocumentSnapshot doc = snapshot.docs[0];
    Map<String, dynamic> asMap = doc.data() as Map<String, dynamic>;
    if (asMap.containsKey('suggestedEmailAddresses')) {
      List<String> emails = List<String>.from(doc['suggestedEmailAddresses']);
      return emails.where((email) {
        final queryLower = query.toLowerCase();
        final emailLower = email.toLowerCase();
        return emailLower.contains(queryLower);
      }).toList();
    }
    return [];
  }

  // Update Operations
  static Future<void> updateStack(
      String stackId, String name, List<String> tags) {
    final docData = {
      'name': name,
      'tags': tags,
    };
    return stacksCollectionRef.doc(stackId).update(docData).then(
          (_) => debugPrint("Stack updated successfully"),
          onError: (e) => debugPrint("Error occurred when updating Stack: $e"),
        );
  }

  static Future<void> updateCard(
      EachCard card, String name, String frontContent, String backContent) {
    final docData = {
      'name': name,
      'frontContent': frontContent,
      'backContent': backContent,
    };
    return stacksCollectionRef
        .doc(card.stackId)
        .collection(cardCollectionName)
        .doc(card.cardId)
        .update(docData)
        .then(
          (_) => debugPrint("Card updated successfully"),
          onError: (e) => debugPrint("Error occurred when updating card: $e"),
        );
  }

  // Delete Operations
  static Future<void> deleteStack(String stackId) {
    return stacksCollectionRef.doc(stackId).delete().then(
          (_) => debugPrint("Stack deleted successfully"),
          onError: (e) => debugPrint("Error occurred when deleting stack: $e"),
        );
  }

  static Future<void> deleteCard(EachCard card) {
    return stacksCollectionRef
        .doc(card.stackId)
        .collection(cardCollectionName)
        .doc(card.cardId)
        .delete()
        .then(
          (_) => debugPrint("Card deleted successfully"),
          onError: (e) => debugPrint("Error occurred when deleting card: $e"),
        );
  }

  static void deleteTag(String stackId, String tagName) {
    stacksCollectionRef.doc(stackId).update({
      'tags': FieldValue.arrayRemove([tagName])
    });
  }
}
