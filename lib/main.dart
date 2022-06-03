import 'package:campsu/pages/upload_page.dart';
import 'package:campsu/utils/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'utils/auth.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:campsu/pages/messages.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(MyApp());
}

class MyFirebaseApp extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen(message: snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
            value: AuthService().user,
            initialData: null,
            child: AuthenticationStatus(),
          );
        }
        return const WaitingScreen();
      },
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CS310 Spring'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class AuthenticationStatus extends StatefulWidget {
  const AuthenticationStatus({Key? key}) : super(key: key);

  @override
  State<AuthenticationStatus> createState() => _AuthenticationStatusState();
}

class _AuthenticationStatusState extends State<AuthenticationStatus> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Welcome(analytics: analytics, observer: observer);
    } else {
      return RootApp(analytics: analytics, observer: observer);
    }
  }
}

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text('Connecting to Firebase',
              style: TextStyle(
                fontSize: 24,
              )),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? firstLoad;
  SharedPreferences? prefs;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
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
          '/walkthrough': (context) =>
              Walkthrough(analytics: analytics, observer: observer),
          '/': (context) => Welcome(analytics: analytics, observer: observer),
          RootApp.routeName: (context) =>
              RootApp(analytics: analytics, observer: observer),
          SignUp.routeName: (context) =>
              SignUp(analytics: analytics, observer: observer),
          Login.routeName: (context) =>
              Login(analytics: analytics, observer: observer),
          Messages.routeName: (context) =>
              Messages(analytics: analytics, observer: observer),
          Upload.routeName: (context) =>
              Upload(analytics: analytics, observer: observer),
        },
      );
    } else {
      return MaterialApp(
        // initialRoute: '/login',
        navigatorObservers: <NavigatorObserver>[observer],
        theme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.amber,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/walkthrough': (context) =>
              Walkthrough(analytics: analytics, observer: observer),
          '/': (context) => Welcome(analytics: analytics, observer: observer),
          RootApp.routeName: (context) =>
              RootApp(analytics: analytics, observer: observer),
          SignUp.routeName: (context) =>
              SignUp(analytics: analytics, observer: observer),
          Login.routeName: (context) =>
              Login(analytics: analytics, observer: observer),
          Messages.routeName: (context) =>
              Messages(analytics: analytics, observer: observer),
          Upload.routeName: (context) =>
              Upload(analytics: analytics, observer: observer),
        },
      );
    }
  }
}
