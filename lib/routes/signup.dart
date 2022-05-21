import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/pages/home_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

  static const String routeName = '/signup';
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  String? _name;
  String? _surname;
  String? _email;

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpasword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGNUP',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.headColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
        key: _formkey,
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
                validator: (String? value) {
                  if (value!.isEmpty) {
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  hintText: "Please enter your surname",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _surname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  hintText: "Please enter your mail address",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  hintText: "Please enter your password",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {},
              ),
              TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  hintText: "Please enter your password again",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {},
              ),
              Container(
                  child: Column(
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        // buraya girerse eğer, serbest bir fonksiyon yaz içinde setState olsun
                        // build fonksiyonunu tekrar çalıştırsın ama butonun altında yazı olsun
                        // düzgün yazdıramadın diye

                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    },
                    child: Text(
                      "Sign Up!",
                      style: TextStyle(),
                    ),
                  ),
                  MaterialButton(
                    child: Text("You have an account?\nLogin!"),
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
    );
  }
}
