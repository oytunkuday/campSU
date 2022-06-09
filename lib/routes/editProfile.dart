import 'dart:io' show Platform;
import 'package:campsu/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/utils/screenSizes.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _editState createState() => _editState();

  static const String routeName = '/editprofile';
}

class _editState extends State<EditProfile> {
  
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  
  Future pickImageGallery() async {
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
  
  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 73,
                        height: 73,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: TextButton(
                onPressed: () {
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    textStyle: TextStyle(height: 1)),
                child: const Text('Change Picture',
                    style: TextStyle(color: Colors.blue)),
              )
                      ),
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
                                const Icon(Icons.person_outline_outlined),
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
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
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
  }
}
