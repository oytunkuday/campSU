import 'dart:ui';

import 'package:campsu/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key, this.analytics, this.observer})
      : super(key: key);
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  @override
  State<StatefulWidget> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  MyUser? currUser;
  String name = "";
  String id = '';
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

  void _loadUserInfo() async {
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
      id = doc.docs[0].id;
    });
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'FollowerPage',
      screenClassOverride: 'follow_page',
    );
  }

  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    // TODO: implement build
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
    _setCurrentScreen();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.headColor,
        title: Text(
          'FOLLOWERS',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                if (arg['followers'].contains(doc.get(('email')))) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 30,
                              child: ClipOval(
                                child: Image.network(doc.get('photoUrl')),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              doc.get('name'),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.cancel,
                                    color: Colors.black, size: 15),
                                onPressed: () {
                                  var userid = doc.id;
                                  dynamic followings = doc.get('following');
                                  followings = followings ?? [];
                                  followers = followers ?? [];
                                  var emailoffollower = doc.get(('email'));
                                  if (followers.contains(emailoffollower)) {
                                    followers.removeWhere(
                                        (str) => str == emailoffollower);
                                    if (followings.contains(email)) {
                                      followings
                                          .removeWhere((str) => str == email);
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userid)
                                          .update({
                                        "following": followings
                                      }).then((result) {
                                        print("followers CHANGED");
                                      }).catchError((onError) {
                                        print(onError.toString());
                                      });
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(id)
                                          .update({
                                        "followers": followers
                                      }).then((result) {
                                        print("followers CHANGED");
                                      }).catchError((onError) {
                                        print(onError.toString());
                                      });
                                      setState(() {});
                                    }
                                  }
                                })
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Card();
                }
              }).toList(),
            );
        },
      ),
    );
  }
}
