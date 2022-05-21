import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';

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
      appBar: AppBar(title: const Text('campSU'), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
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
  List<Widget>? buildActions(BuildContext context) {
    //Actions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Leading Icon
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.arrow_menu,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show Result Based On Selection
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
