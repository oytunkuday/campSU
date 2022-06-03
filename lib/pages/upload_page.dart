import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
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

class Upload extends StatefulWidget {
  const Upload({Key? key, this.analytics, this.observer}) : super(key: key);
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  static const String routeName = '/upload';

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      print("Upload complete");
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text('Connected to Firebase')),
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
                                  size: 150,
                                ),
                                onPressed: pickImage,
                              )),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_image != null)
                  OutlinedButton(
                    onPressed: () {
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
            )
          ],
        ),
      ),
    );
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'Upload Page',
      screenClassOverride: 'uploadPage',
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
              "Post",
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
