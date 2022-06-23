// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:campsu/model/user.dart';
import 'package:campsu/utils/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/data/post_json.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';

import 'messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(60), child: getAppBar()),
      body: getBody(),
    );
  }

  DBService dbs = DBService();
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
    });
  }

  Widget getAppBar() {
    _loadUserInfo();
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.headColor,
      title: Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "CampSU",
              style: HeadingTextStyleBlack,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Messages()));
                },
                icon: Icon(
                  Icons.message_outlined,
                  color: Colors.black,
                  size: 32,
                ))
          ],
        ),
      ),
    );
  }

  final db = FirebaseFirestore.instance;
  final currentTime = DateTime.now();
  Widget getBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('posts')
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 332,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 15,
                                          offset: Offset(0, 1))
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 332,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 48,
                                          color: AppColors.postColor)),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 288,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 15,
                                          offset: Offset(0, 1))
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            doc.get('postPhotoUrl')),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 340,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    doc.get('userPhotoUrl'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      doc.get('username'),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Icon(
                                              Icons.share,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 27,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(27),
                                                  color: Colors.grey
                                                      .withOpacity(0.35)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      var postid = doc.id;
                                                      dynamic likes =
                                                          doc.get('likes');
                                                      likes = likes ?? [];
                                                      String s =
                                                          "$username liked your post!";
                                                      dbs.addNotifAutoId(
                                                          DateTime.now(),
                                                          s,
                                                          doc.get('email'));

                                                      if (!likes
                                                          .contains(email)) {
                                                        likes.add(email);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('posts')
                                                            .doc(postid)
                                                            .update({
                                                          "likes": likes
                                                        }).then((result) {
                                                          print(
                                                              "LIKES CHANGED");
                                                        }).catchError(
                                                                (onError) {
                                                          print(onError
                                                              .toString());
                                                        });
                                                        setState(() {});
                                                      } else {
                                                        likes.removeWhere(
                                                            (str) =>
                                                                str == email);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('posts')
                                                            .doc(postid)
                                                            .update({
                                                          "likes": likes
                                                        }).then((result) {
                                                          print(
                                                              "LIKES CHANGED");
                                                        }).catchError(
                                                                (onError) {
                                                          print("onError");
                                                        });
                                                        setState(() {});
                                                      }
                                                    },
                                                    icon: Icon(
                                                        CupertinoIcons.heart,
                                                        color: Colors.white,
                                                        size: 15),
                                                  ),
                                                  Text(
                                                    "${doc.get('likes').length}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 70,
                                              height: 27,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(27),
                                                  color: Colors.grey
                                                      .withOpacity(0.35)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.comment_outlined,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    "${doc.get('comments').length}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 70,
                                              height: 27,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(27),
                                                  color: Colors.grey
                                                      .withOpacity(0.35)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.save_alt_rounded,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                color: AppColors.postColor,
                                                child: Text(
                                                    "${doc.get('content')}"))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        });
  }
}
