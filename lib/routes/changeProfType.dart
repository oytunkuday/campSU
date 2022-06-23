import 'package:campsu/model/user.dart';
import 'package:campsu/pages/follow_page.dart';
import 'package:campsu/pages/following_page.dart';
import 'package:campsu/pages/pp_page.dart';
import 'package:campsu/pages/upload_page.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:campsu/ui/navbar.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:campsu/routes/login.dart';
import 'package:campsu/routes/signup.dart';
import 'package:campsu/routes/welcome.dart';
import 'package:campsu/routes/walkthrough.dart';
import 'package:provider/provider.dart';
import 'package:campsu/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campsu/utils/auth.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:campsu/pages/messages.dart';

class ChangeProfType extends StatefulWidget {
  const ChangeProfType({Key? key}) : super(key: key);

  @override
  State<ChangeProfType> createState() => _ChangeProfTypeState();
}

class _ChangeProfTypeState extends State<ChangeProfType> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? currUser;
  String name = "";
  String bio = "";
  String username = "";
  String email = "";
  String photoUrl = "";
  List<dynamic> followers = [];
  List<dynamic> following = [];
  List<dynamic> posts = [];
  String website = "";
  bool profType = false;
  List<dynamic> savedposts = [];

  void changeType(val) async {
    var x;
    final q = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs.map((doc) {
              print("asjfdashdas");
              x = doc.id;
            }).toList());
    FirebaseFirestore.instance
        .collection('users')
        .doc(x)
        .update({"profType": val}).then((result) {
      print("new USer true");
    }).catchError((onError) {
      print("onError");
    });
  }

  final db = FirebaseFirestore.instance;
  _loadUserInfo() async {
    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _user?.email)
        .get();

    setState(() {
      name = doc.docs[0]['name'];
      username = doc.docs[0]['username'];
      followers = doc.docs[0]['followers'];
      following = doc.docs[0]['following'];
      posts = doc.docs[0]['posts'];
      website = doc.docs[0]['website'];
      photoUrl = doc.docs[0]['photoUrl'];
      bio = doc.docs[0]['bio'];
      email = doc.docs[0]['email'];
      profType = doc.docs[0]['profType'];
      savedposts = doc.docs[0]['savedposts'];
    });
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
    currUser = MyUser(
      name: name,
      bio: bio,
      username: username,
      email: email,
      photoUrl: photoUrl,
      followers: followers,
      following: following,
      posts: posts,
      website: website,
      profType: profType,
      savedposts: savedposts,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.headColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 100,
          // ignore: sort_child_properties_last
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Your current profile type"),
              ChoiceChip(
                selected: profType,
                label: Text("${profType ? 'Private' : 'Public'}"),
                onSelected: (val) {
                  changeType(val);
                  setState(() {});
                },
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.fromLTRB(8, 80, 8, 0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadiusDirectional.circular(50),
            color: Color.fromARGB(255, 195, 200, 190),
          ),
        ),
      ),
    );
  }
}
