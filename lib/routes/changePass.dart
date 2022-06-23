import 'dart:io' show Platform;
import 'package:campsu/pages/follow_page.dart';
import 'package:campsu/pages/following_page.dart';
import 'package:campsu/pages/pp_page.dart';
import 'package:campsu/pages/upload_page.dart';
import 'package:campsu/utils/colors.dart';
import 'package:email_validator/email_validator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/ui/navbar.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:campsu/routes/login.dart';
import 'package:campsu/routes/signup.dart';
import 'package:campsu/routes/welcome.dart';
import 'package:campsu/routes/walkthrough.dart';
import 'package:provider/provider.dart';
import 'package:campsu/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campsu/utils/auth.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:campsu/pages/messages.dart';
import 'package:campsu/pages/profile_page.dart';

import '../utils/styles.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String current_pass = '';
  String new_pass = '';

  TextEditingController _currentpassword = TextEditingController();

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title, style: kBoldLabelStyle),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message, style: kLabelStyle),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.headColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: "Please enter your current password",
                    ),
                    validator: (value) {
                      if (value != null && value.trim().isEmpty) {
                        return "Please enter your current password";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      current_pass = value ?? "";
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: "Please enter your new password",
                    ),
                    validator: (value) {
                      if (value != null && value.trim().isEmpty) {
                        return "Please enter your new password";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      new_pass = value ?? "";
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    controller: _currentpassword,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: "Please enter your new password again",
                    ),
                    validator: (String? value) {
                      if (value != null && value.trim().isEmpty) {
                        return "Please enter your new password again";
                      } else if (value != _currentpassword.text) {
                        return "Passwords do not match";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {},
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        //setState(() {});
                        Navigator.pushNamed(context, '/profilepage');
                      } else {
                        _showDialog('Form Error', 'Your inputs are invalid');
                      }
                    },
                    child: const Text(
                      "Save changes!",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
