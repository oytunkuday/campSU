import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';

import '../users/usersClass.dart';

Widget getAppBar() {
  return AppBar(
    backgroundColor: AppColors.headColor,
    elevation: 0,
  );
}

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);
  @override
  _searchScreen createState() => _searchScreen();
}

class _searchScreen extends State<searchScreen> {

  List<Object> allUsers = [];
  List<Object> _resultsList = [];

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search');

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserList();
  }

  Future getUserList() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .get();

    setState(() {
      allUsers = List.from(data.docs.map((doc) => UsersClass.fromSnapshot(doc)));
    });
    searchResultList();
  }

  void _onSearchChanged() {
    searchResultList();
    print('Text field: ${myController.text}');
  }

  void searchResultList() {
    List<Object> showResults = [];

    if(myController.text != "") {
      for(var index = 0; index < allUsers.length; index++){

        final UsersClass productSnapshot = allUsers[index] as UsersClass;

        var username = productSnapshot.username.toLowerCase();
        if(username.contains(myController.text.toLowerCase())) {
          showResults.add(allUsers[index]);
        }
      }
    }
    else {
      showResults = [];
    }

    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          backgroundColor: AppColors.headColor,
        title: customSearchBar,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                myController.addListener(_onSearchChanged);
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: 'username search',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }  else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Search');
                }
              });
            },
            icon: customIcon,

          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _resultsList.length,
                itemBuilder: (context, index) {
                  UsersClass user = _resultsList[index] as UsersClass;
                  return Card(
                      elevation: 2,
                      color: const Color(0xAACCCCCC),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          user.username,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}