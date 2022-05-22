import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/pages/home_page.dart';

import '../pages/root_app.dart';

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
          ' SIGNUP',
          style: HeadingTextStyleBlack,
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
                validator: (value) {
                  if (value != null && value.trim().isEmpty) {
                    return "Name field cannot be empty";
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
                validator: (value) {
                  if (value != null && value.trim().isEmpty) {
                    return "Surname field cannot be empty";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _surname = value;
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
                  _email = value;
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
                onSaved: (value) {},
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
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return null;
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RootApp()));
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
    );
  }
}
