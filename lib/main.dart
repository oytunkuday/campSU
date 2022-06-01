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
import 'package:firebase_core/firebase_core.dart';

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



  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyFirebaseApp());



 
 /*
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
  */
}

class MyFirebaseApp extends StatelessWidget {
  
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return MaterialApp(
            home: ErrorScreen(message: snapshot.error.toString(),),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
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
        }
        return MaterialApp(home : Waitingscreen());
      },);
  }
}

class ErrorScreen extends StatelessWidget {
   ErrorScreen({Key? key, required this.message}) : super(key: key);

String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampSu'),
      ),
      body: Center(
        child: Text(message)
      )
    );

  }
}

class Waitingscreen extends StatelessWidget {
  const Waitingscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Text('Trying to connect to Firebase')
    );
  }
}