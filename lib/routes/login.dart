import 'dart:io' show Platform;
import 'dart:convert';
import 'package:campsu/routes/api.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
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
class Login extends StatefulWidget {
  Login({Key? key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  @override
  _LoginState createState() => _LoginState();

  static const String routeName = '/login';
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();}

class _LoginState extends State<Login> {
  int loginCounter = 0;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  late String s;

  final AuthService _auth = AuthService();

  Future<void> _setCurrentScreen() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'Login Page',
      screenClassOverride: 'loginPage',
    );
  }

  Future loginUser() async {
    dynamic result = await _auth.signInWithEmailPass(email, pass);
    if (result is String) {
      _showDialog('Login Error', result);
    } else if (result is User) {
      //User signed in
      Navigator.pushNamedAndRemoveUntil(
          context, RootApp.routeName, (route) => false);
    } else {
      _showDialog('Login Error', result.toString());
    }
  }

  Future getUsers() async {
    final url = Uri.parse(API.allUsers);
    final response = await http.get(Uri.https(url.authority, url.path));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //SUCCESS
      //_showDialog('HTTP: ${response.statusCode}', response.body);
      /*
      Map<String, dynamic> post = jsonDecode(response.body);
      JsonPost newPost = JsonPost(
          title: post['title'],
          body: post['body'],
          userId: post['userId'],
          postId: post['id']);
      print(newPost);
      */
      var responseList = jsonDecode(response.body) as List;
      /*
      List<JsonPost> items = responseList.map(
              (postItem) => JsonPost.fromJson(postItem)
      ).toList();
      print('${items[10]}');
       */

      List<MyUser> users =
          responseList.map((user) => MyUser.fromJson(user)).toList();
      print('Latitude: ${users[1]}');
      print('Longitude: ${users[1]}');
    } else {
      _showDialog('HTTP: ${response.statusCode}', response.body);
    }
  }

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
                  },)],);} });}
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
            context, '/rootapp', (route) => false);}});}
  @override
  Widget build(BuildContext context) {
    _setCurrentScreen();
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
                    onSaved: (value) {
                      email = value ?? '';
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
                    onSaved: (value) {
                      pass = value ?? "";
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await loginUser();
                        setState(() {});
                      } else {
                        _showDialog('Form Error', 'Your form is invalid');
                      }
                    },
                    child: const Text(
                      "Log in!",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      dynamic user = await _auth.signInWithGoogle();
                      if (user != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/rootapp', (route) => false);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Sign in with Gmail',
                        style: kButtonDarkTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.headingColor,
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
      ),
    );
  }
}
