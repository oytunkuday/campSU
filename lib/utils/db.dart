import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campsu/model/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DBService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  String s = '';
  int i = 0;
  Future addUserAutoID(String name,
  String bio,
  String username,
  String email,
  String photoUrl,
  List<dynamic> followers,
  List<dynamic> following,
  List<dynamic> posts,
  String website,
  Geo? geo,
  bool profType,
  List<dynamic> savedposts,) async {
    userCollection
        .add({ "name":name,
   "bio":bio,
   "username":username,
   "email":email,
   "photoUrl":photoUrl,
   "followers":followers,
   "following":following,
  "posts":posts,
  "website":website,
   "geo":geo,
  "profType":profType,
  "savedposts":savedposts,

        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }
  Future addPostAutoID(
  String username,
  String email,
  DateTime date,
  String userPhotoUrl,
  String postPhotoUrl,
  List<dynamic> comments,
  List<dynamic> likes,
  String content,
  Geo? geo,
  bool Liked) async {
    postCollection.add({
      "username":username,
      "email":email,
      "date":date,
      "userPhotoUrl":userPhotoUrl,
      "postPhotoUrl":postPhotoUrl,
      "comments":comments,
      "likes":likes,
      "content":content,
      "geo":geo,
      "Liked":Liked

    })
        .then((value) => print('Post Added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future<String> getDocId(email) async {

    FirebaseAuth _auth = FirebaseAuth.instance;
      User? _user = _auth.currentUser;

      dynamic x;
      final q = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value.docs.map((doc) {
                print("asjfdashdas");
                x = doc.id;
              }).toList());
    return x;
  }

}
