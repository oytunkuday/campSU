import 'package:flutter/material.dart';
import 'package:campsu/ui/navbar.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:campsu/routes/login.dart';
import 'package:campsu/routes/signup.dart';
import 'package:campsu/routes/welcome.dart';
import 'package:campsu/routes/walkthrough.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    initialRoute: '/walkthrough',
    routes: {
      '/walkthrough': (context) => Walkthrough(),
      '/': (context) => const Welcome(),
      SignUp.routeName: (context) => SignUp(),
      Login.routeName: (context) => Login(),
    },
  ));
}
