// ignore_for_file: deprecated_member_use

import 'package:campsu/model/user.dart';
import 'package:campsu/pages/saved_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campsu/data/me_post_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:campsu/routes/editProfile.dart';
import 'package:campsu/routes/settingsProfile.dart';
import 'package:campsu/pages/follow_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPhoto = true;
  late VideoPlayerController _controller;
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

  final db = FirebaseFirestore.instance;

  final postslist = [];
  @override
  void initState() {
    _loadUserInfo();
    super.initState();
    _controller = VideoPlayerController.network(meVideoList[0]['videoUrl']);
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
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180), child: getAppBar()),
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
    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    return FutureBuilder<QuerySnapshot>(
        future: _loadUserInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else
            return AppBar(
                elevation: 2,
                actions: [
                  IconButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      icon: Icon(Icons.logout))
                ],
                backgroundColor: AppColors.headColor,
                flexibleSpace: SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [SizedBox(height: 6)],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 1),
                          Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Container(
                                width: 73,
                                height: 73,
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
                          Column(
                            children: [
                              Text(
                                "Posts",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${posts.length}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/followers',
                                      arguments: {
                                        'followers': followers,
                                      });
                                },
                                child: Text("Followers",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ),
                              Text(
                                '${followers.length}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/followings',
                                      arguments: {
                                        'following': currUser!.followers,
                                      });
                                },
                                child: Text("Following",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ),
                              Text(
                                '${following.length}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingsProfile()));
                                    ;
                                  },
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.black,
                                    size: 32,
                                  ))
                            ],
                          )
                        ]),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      Text(
                        " @${username}",
                        style: TextStyle(fontSize: 15, height: 1),
                      ),
                      SizedBox(width: 244),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                          ;
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            textStyle: TextStyle(height: 1)),
                        child: const Text('Edit Profile',
                            style: TextStyle(color: Colors.blue)),
                      )
                    ]),
                    Text(
                      "${bio}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )));
        });
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Color.fromARGB(255, 254, 202, 134),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            //color: const Color.fromARGB(255, 254, 202, 134),
                            //textColor: Colors.black,
                            onPressed: () {
                              setState(() {
                                isPhoto = true;
                              });
                            },
                            child: const Text(
                              'All Posts',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          OutlinedButton(
                            //color: const Color.fromARGB(255, 254, 202, 134),
                            //textColor: Colors.black,
                            onPressed: () {
                              setState(() {
                                isPhoto = false;
                              });
                            },
                            child: const Text(
                              'Videos',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SavedPage()));
                                ;
                              },
                              icon: Icon(
                                Icons.bookmark_border,
                                color: Colors.black,
                                size: 32,
                              )),
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  isPhoto
                      ? Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: List.generate(mePostList.length, (index) {
                            return Container(
                              width: (size.width - 60) / 2,
                              height: (size.width - 60) / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(mePostList[index]),
                                      fit: BoxFit.cover)),
                            );
                          }),
                        )
                      : Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: List.generate(meVideoList.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                playVideo(
                                    context, meVideoList[index]['videoUrl']);
                              },
                              child: Container(
                                width: (size.width - 60) / 2,
                                height: (size.width - 60) / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            meVideoList[index]['img']),
                                        fit: BoxFit.cover)),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        )
                ],
              ),
            );
          }
        });
  }

  playVideo(BuildContext context, videoUrl) {
    _controller = VideoPlayerController.network(videoUrl);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )));
  }
}
