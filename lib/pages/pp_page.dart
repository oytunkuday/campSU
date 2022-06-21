import 'package:campsu/model/user.dart';
import 'package:campsu/utils/db.dart';
import 'package:campsu/utils/screenSizes.dart';
import 'package:campsu/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/data/message_samples.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

class UploadPP extends StatefulWidget {
  const UploadPP({Key? key, this.analytics, this.observer}) : super(key: key);
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  static const String routeName = '/changepp';

  @override
  _UploadPPState createState() => _UploadPPState();
}

class _UploadPPState extends State<UploadPP> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  String posttext = "";
  String posturl = "";
  DBService dbs = DBService();
  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future pickImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = pickedFile;
    });
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
  void dispose() {
    super.dispose();
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');

    try {
      UploadTask task = firebaseStorageRef.putFile(File(_image!.path));
      var downurl = await (await task).ref.getDownloadURL();
      String posturl = downurl.toString();
      print("Upload complete");
      FirebaseAuth _auth = FirebaseAuth.instance;
      User? _user = _auth.currentUser;

      dynamic x;
      print("SELAM $email");
      final q = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value.docs.map((doc) {
                print("asjfdashdas");
                x = doc.id;
              }).toList());
      print("hello there $x");

      setState(() {
        _image = null;
      });
    } on FirebaseException catch (e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 50),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: _image != null
                            ? Image.file(File(_image!.path))
                            : TextButton(
                                child: Icon(
                                  Icons.browse_gallery,
                                  size: 50,
                                ),
                                onPressed: pickImage,
                              )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: _image != null
                            ? Image.file(File(_image!.path))
                            : TextButton(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                ),
                                onPressed: pickImageCamera,
                              )),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_image != null)
                  Container(
                    width: screenWidth(context, dividedBy: 4.8),
                    child: Form(
                      key: _formKey,
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
                                const Icon(Icons.message),
                                const SizedBox(width: 2),
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
                          posttext = value ?? "";
                        },
                      ),
                    ),
                  ),
                if (_image != null)
                  OutlinedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      uploadImageToFirebase(context);
                    },
                    child: Text('Upload image'),
                  ),
                SizedBox(
                  width: 16,
                ),
                if (_image != null)
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                    },
                    child: Text('Cancel'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'ChangePP',
      screenClassOverride: 'ChangePP',
    );
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
              "Change Profile Picture",
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
}
