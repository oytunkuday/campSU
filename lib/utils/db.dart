import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  String s = '';
  int i = 0;
  Future addUserAutoID(String name, String mail, String token) async {
    userCollection
        .add({
          'name': name,
          'email': mail,
          'userToken': token,
          'username': s,
          'website': s,
          'id': i,
          'bio': s,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }
}
