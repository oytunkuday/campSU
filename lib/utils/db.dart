import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campsu/model/post.dart';
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
  Geo geo,
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
}
