// ignore_for_file: prefer_const_constructors

import 'package:campsu/model/post.dart';
import 'package:campsu/pages/post_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Widget getAppBar() {
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
        stream: db.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PostView()),
                    );
                  },
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
                        Column(
                          children: List.generate(postsList.length, (index) {
                            return Padding(
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
                                    height: 339,
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
                                                    backgroundImage:
                                                        NetworkImage(
                                                      doc.get('userPhotoUrl'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        doc.get('username'),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
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
                                                        BorderRadius.circular(
                                                            27),
                                                    color: Colors.grey
                                                        .withOpacity(0.35)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.heart,
                                                      color: Colors.white,
                                                      size: 15,
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
                                                        BorderRadius.circular(
                                                            27),
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
                                                        BorderRadius.circular(
                                                            27),
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        });
  }
}
