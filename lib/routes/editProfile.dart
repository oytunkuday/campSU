import 'dart:io' show Platform;
import 'package:campsu/data/me_post_json.dart';
import 'package:campsu/model/user.dart';
import 'package:campsu/pages/pp_page.dart';
import 'package:campsu/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/utils/screenSizes.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class EditProfile extends StatefulWidget {
  @override
  _editState createState() => _editState();

  static const String routeName = '/editprofile';
}

class _editState extends State<EditProfile> {
  bool isPhoto = true;
  final _formKey = GlobalKey<FormState>();
  late VideoPlayerController _controller;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String namech = '';
  String nicknamech = '';
  String bioch = '';
  String urlch = '';

  Future uploadToFirebase(BuildContext context) async {
    try {
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
      print("hello there $x");
      FirebaseFirestore.instance
          .collection('users')
          .doc(x)
          .update({"name": namech}).then((result) {
        print("new USer true");
      }).catchError((onError) {
        print("onError");
      });
      setState(() {});
    } on FirebaseException catch (e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }

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

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
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

  @override
  Widget build(BuildContext context) {
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
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Edit Profile',
                    style: kAppBarTitleTextStyle,
                  ),
                  backgroundColor: AppColors.headColor,
                  centerTitle: true,
                  elevation: 0.0,
                ),
                body: Scaffold(
                  backgroundColor: AppColors.backgroundColor,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: Dimens.regularPadding,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
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
                            Center(
                              child: Container(
                                  child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UploadPP()));
                                },
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    textStyle: TextStyle(height: 1)),
                                child: const Text('Change Picture',
                                    style: TextStyle(color: Colors.blue)),
                              )),
                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.all(24),
                              width: screenWidth(context, dividedBy: 1.1),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: AppColors.postColor,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  label: Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        const Icon(
                                            Icons.person_outline_outlined),
                                        const SizedBox(width: 4),
                                        const Text('Name'),
                                      ],
                                    ),
                                  ),
                                  fillColor: AppColors.textFieldFillColor,
                                  filled: true,
                                  labelStyle: kBoldLabelStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onSaved: (value) {
                                  namech = value ?? name;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(24),
                              width: screenWidth(context, dividedBy: 1.1),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: AppColors.postColor,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  label: Container(
                                    width: 116,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.person),
                                        const SizedBox(width: 4),
                                        const Text('Nickname'),
                                      ],
                                    ),
                                  ),
                                  fillColor: AppColors.textFieldFillColor,
                                  filled: true,
                                  labelStyle: kBoldLabelStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onSaved: (value) {
                                  nicknamech = value ?? username;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(24),
                              width: screenWidth(context, dividedBy: 1.1),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: AppColors.postColor,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  label: Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.terrain_rounded),
                                        const SizedBox(width: 4),
                                        const Text('Biography'),
                                      ],
                                    ),
                                  ),
                                  fillColor: AppColors.textFieldFillColor,
                                  filled: true,
                                  labelStyle: kBoldLabelStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onSaved: (value) {
                                  bioch = value ?? bio;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(24),
                              width: screenWidth(context, dividedBy: 1.1),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: AppColors.postColor,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  label: Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.menu_book),
                                        const SizedBox(width: 4),
                                        const Text('Field'),
                                      ],
                                    ),
                                  ),
                                  fillColor: AppColors.textFieldFillColor,
                                  filled: true,
                                  labelStyle: kBoldLabelStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            OutlinedButton(
                              onPressed: () {
                                uploadToFirebase(context);
                                _formKey.currentState!.save();

                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Save Changes',
                                  style: kButtonDarkTextStyle,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.headColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
        });
  }
}
