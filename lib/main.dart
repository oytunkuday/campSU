import 'package:flutter/material.dart';
import 'package:campsu/pages/bottom_bar.dart';

import 'package:campsu/routes/login.dart';
import 'package:campsu/routes/signup.dart';
import 'package:campsu/routes/welcome.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    routes: {
      '/': (context) => const Welcome(),
      SignUp.routeName: (context) => SignUp(),
      Login.routeName: (context) => Login(),
    },
  ));
}
