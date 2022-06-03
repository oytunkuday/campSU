import 'package:campsu/utils/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/pages/home_page.dart';
import 'package:campsu/routes/login.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:io' show Platform;
import 'dart:convert';
import 'package:campsu/routes/api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/utils/screenSizes.dart';
import 'package:campsu/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:campsu/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campsu/utils/auth.dart';

import '../model/user.dart';
import 'package:campsu/utils/db.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  @override
  _SignUpState createState() => _SignUpState();

  static const String routeName = '/signup';
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  String name = "";
  String surname = "";
  String email = "";
  String pass = "";
  late String s;
  final AuthService _auth = AuthService();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpasword = TextEditingController();
  DBService db = DBService();
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

  Future signUser() async {
    dynamic result = await _auth.registerUserWithEmailPass(email, pass);
    if (result is String) {
      _showDialog('Sign Up Error', result);
    } else if (result is User) {
      //User signed in

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      _showDialog('Sign Up Error', result.toString());
    }
  }

  @override
  void initState() {
    _setCurrentScreen();
    // TODO: implement initState
    super.initState();
    s = '';

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/rootapp', (route) => false);
      }
    });
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'SignUp Page',
      screenClassOverride: 'signupPage',
    );
  }

  @override
  Widget build(BuildContext context) {
    _setCurrentScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' SIGNUP',
          style: HeadingTextStyleBlack,
        ),
        backgroundColor: AppColors.headColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                TextFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    hintText: "Please enter your name",
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return "Name field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    name = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    hintText: "Please enter your surname",
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return "Surname field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    surname = value ?? '';
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    hintText: "Please enter your mail address",
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return "Email address cannot be empty";
                    } else if (!EmailValidator.validate(value!)) {
                      return "please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    email = value ?? '';
                  },
                ),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    hintText: "Please enter your password",
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return "Password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    pass = value ?? '';
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _confirmpasword,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    hintText: "Please enter your password again",
                  ),
                  validator: (String? value) {
                    if (value != null && value.trim().isEmpty) {
                      return "Password cannot be empty";
                    } else if (value != _password.text) {
                      return "Passwords do not match";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {},
                ),
                Container(
                    child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                          db.addUserAutoID(name, email, 'token');
                          print("selamlar");
                          await signUser();
                          setState(() {});
                        } else {
                          _showDialog('Form Error', 'Your form is invalid');
                        }
                      },
                      child: Text(
                        "Sign Up!",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    MaterialButton(
                      child: Text("You have an account? Login!"),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                )),
                SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
