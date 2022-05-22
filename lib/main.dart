import 'package:campsu/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:campsu/ui/navbar.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:campsu/routes/login.dart';
import 'package:campsu/routes/signup.dart';
import 'package:campsu/routes/welcome.dart';
import 'package:campsu/routes/walkthrough.dart';
import 'package:campsu/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    theme: ThemeData(
      primaryColor: Colors.amber,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.amber,
      ),
    ),
    initialRoute: '/walkthrough',
    routes: {
      '/walkthrough': (context) => Walkthrough(),
      '/': (context) => const Welcome(),
      SignUp.routeName: (context) => SignUp(),
      Login.routeName: (context) => Login(),
    },
  ));
}
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? firstLoad;
  SharedPreferences? prefs;

  decideRoute() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      firstLoad = (prefs!.getInt('appInitialLoad') ?? 0);
    });
  }

  initState() {
    super.initState();
    decideRoute();
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad == null) {
      return Container();
    } else if (firstLoad == 0) {
      firstLoad = 1;
      prefs!.setInt('appInitialLoad', firstLoad!);
      return MaterialApp(
        // initialRoute: '/login',
        theme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.amber,
          ),
        ),
        initialRoute: '/walkthrough',
        routes: {
          '/walkthrough': (context) => Walkthrough(),
          '/': (context) => const Welcome(),
          SignUp.routeName: (context) => SignUp(),
          Login.routeName: (context) => Login(),
        },
      );
    } else {
      return MaterialApp(
        // initialRoute: '/login',
        theme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.amber,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/walkthrough': (context) => Walkthrough(),
          '/': (context) => const Welcome(),
          SignUp.routeName: (context) => SignUp(),
          Login.routeName: (context) => Login(),
        },
      );
    }
  }
}
