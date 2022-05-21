import 'dart:io' show Platform;
import 'package:campsu/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/utils/screenSizes.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/pages/root_app.dart';

class EditProfile extends StatefulWidget {
  @override
  _editState createState() => _editState();

  static const String routeName = '/editprofile';
}

class _editState extends State<EditProfile> {
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
          body: Padding(
            padding: Dimens.regularPadding,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(24),
                    width: screenWidth(context, dividedBy: 1.1),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
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
                            color: AppColors.primary,
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
                            color: AppColors.primary,
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
                            color: AppColors.primary,
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
                            color: AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
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
        ));
  }
}
