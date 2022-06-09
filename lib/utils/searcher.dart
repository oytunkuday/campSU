import 'package:cloud_firestore/cloud_firestore.dart';

class Searcher {
  searchFind(String TextField) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('username',
        isEqualTo: TextField.substring(0, 1).toUpperCase())
        .get();
  }
}