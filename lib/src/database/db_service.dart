import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/models/each_card.dart';

class DBService {
  static final db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final stacksCollectionRef = db.collection("decks");

  static Future addStack(String stackName) {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("uid empty");
    }

    return stacksCollectionRef.add({"uid": uid, "name": stackName, "tags": []});
  }

  static Future addCard(String stackId, String text) {
    return stacksCollectionRef
        .doc(stackId)
        .collection("cards")
        .add({"name": text});
  }

  static List<CardStack> _cardStackListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> asMap = doc.data() as Map<String, dynamic>;
      return CardStack(doc.id, doc['name'], doc['uid'],
          asMap.containsKey('tags') ? List<String>.from(doc['tags']) : []);
    }).toList();
  }

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

  static List<EachCard> _eachCardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => EachCard(doc['name'])).toList();
  }

  static Stream<List<EachCard>> getCards(String stackId) {
    final cardsCollectionRef =
        stacksCollectionRef.doc(stackId).collection("cards");

    return cardsCollectionRef.snapshots().map(_eachCardListFromSnapshot);
  }

  static Future<void> addTagToStack(String stackId, String tag) {
    return stacksCollectionRef.doc(stackId).update({
      'tags': FieldValue.arrayUnion([tag])
    });
  }
}
