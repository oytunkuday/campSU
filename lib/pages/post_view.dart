import "dart:async";
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/model/post.dart';
import 'package:campsu/model/user.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/utils/colors.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.headColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.message_outlined,
                    color: Colors.black,
                    size: 32,
                  ))
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
                    border: Border.all(width: 48, color: AppColors.postColor)),
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
                          //doc.get('postPhotoUrl')
                          "https://imgrosetta.mynet.com.tr/file/12528299/640xauto.jpg"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    //doc.get('userPhotoUrl'),
                                    "https://imgrosetta.mynet.com.tr/file/12528299/640xauto.jpg"),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //doc.get('username'),
                                    "Recep Ivedik",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 70,
                            height: 27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.grey.withOpacity(0.35)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                Text(
                                  //"${doc.get('likes').length}",
                                  "31",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.grey.withOpacity(0.35)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                Text(
                                  //"${doc.get('comments').length}",
                                  "31",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.grey.withOpacity(0.35)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ),
      ),
    );
  }
}
