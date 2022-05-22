import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.headColor,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ]),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: AppColors.headColor, // affects AppBar's background color
        textTheme: const TextTheme(
            headline6: TextStyle(
                // headline 6 affects the query text
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    //Actions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Leading Icon
    return IconButton(
        onPressed: () {
          //close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.arrow_menu,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show Result Based On Selection
    return Container(
      color: AppColors.backgroundColor,
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Show When Searched
    final suggestionList = query.isEmpty ? recentSearches : searchDATA;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.no_photography),
          title: Text(suggestionList[index])),
      itemCount: suggestionList.length,
    );
  }
}

final recentSearches = [];
final searchDATA = ['Oytun', 'Bengisu', 'Bora', 'Hamit', 'Berkehan'];
