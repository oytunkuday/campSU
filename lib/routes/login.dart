import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/utils/screenSizes.dart';
import 'package:campsu/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:campsu/pages/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  static const String routeName = '/login';
}

class _LoginState extends State<Login> {
  int loginCounter = 0;
  final _formKey = GlobalKey<FormState>();
  String? _email = '';
  String? _pass = '';

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
        title: Text(
          'LOGIN',
          style: HeadingTextStyleBlack,
        ),
        backgroundColor: AppColors.headColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    hintText: "Please enter your email address",
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
                  onSaved: (String? value) {
                    _email = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    hintText: "Please enter your password",
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return "Please enter your password";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String? value) {
                    _pass = value;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RootApp()));
                    } else {}
                  },
                  child: const Text(
                    "Log in!",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                MaterialButton(
                  child: const Text("Don't have an account? Sign up!"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
