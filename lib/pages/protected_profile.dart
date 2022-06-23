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

class PrivateProfilePage extends StatefulWidget {
  const PrivateProfilePage({Key? key}) : super(key: key);

  @override
  _PrivateProfilePageState createState() => _PrivateProfilePageState();
}

class _PrivateProfilePageState extends State<PrivateProfilePage> {
  bool isPhoto = true;

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

  //this will get other user's info afterwards
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

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
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
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180), child: getAppBar()),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
        elevation: 2,
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         await _auth.signOut();
        //         Navigator.pushNamedAndRemoveUntil(
        //             context, '/', (route) => false);
        //       },
        //       icon: Icon(Icons.logout))
        // ],
        backgroundColor: AppColors.headColor,
        flexibleSpace: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [SizedBox(height: 6)],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                  const Text(
                    "Posts",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${posts.length}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/followers', arguments: {
                        'followers': followers,
                      });
                    },
                    child: const Text("Followers",
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ),
                  Text(
                    '${followers.length}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/followings', arguments: {
                        'following': currUser!.followers,
                      });
                    },
                    child: const Text("Following",
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ),
                  Text(
                    '${following.length}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ]),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(children: [
              Text(
                " @${username}",
                style: TextStyle(fontSize: 15, height: 1),
              ),
              SizedBox(width: 220),
            ]),
            Text(
              "${bio}",
              style: TextStyle(fontSize: 15),
            ),
          ],
        )));
  }

  
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50
          ),
          const Icon(
            Icons.lock_outlined, 
            size: 150,
            color: Color.fromARGB(171, 0, 0, 0),),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "          This profile is private",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 3,
          ),
          TextButton(
                onPressed: () {
                  //follow request
                  
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    textStyle: TextStyle(height: 1.5)),
                child: const Text('Send a Follow Request!',
                    style: TextStyle(color: Color.fromARGB(255, 239, 151, 18))),
              ),
        ],
      ),
    );
  }

}