import 'package:campsu/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campsu/data/post_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/pages/root_app.dart';

class sadecePPPage extends StatefulWidget {
  const sadecePPPage({Key? key, this.analytics, this.observer})
      : super(key: key);
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  static const String routeName = '/sadecePP';
  @override
  _sadecePPPageState createState() => _sadecePPPageState();
}

class _sadecePPPageState extends State<sadecePPPage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  Future<QuerySnapshot> _loadUserInfo() async {
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
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _user?.email)
        .get();
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.headColor,
      title: Padding(
        padding: const EdgeInsets.only(right: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile picture",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    _loadUserInfo();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: Center(
          child: Container(
            width: 475,
            height: 475,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.black)),
            child: Center(
              child: Container(
                width: 474,
                height: 474,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: NetworkImage(photoUrl == ''
                            ? 'https://www.pngfind.com/mpng/iwowowR_koren-hosnell-profile-icon-white-png-transparent-png/'
                            : photoUrl),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        )));
  }
}
