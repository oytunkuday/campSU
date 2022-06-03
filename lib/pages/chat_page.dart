import 'package:flutter/material.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';

import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  @override
  _ChatPageState createState() => _ChatPageState();
  
}

class _ChatPageState extends State<ChatPage> {

    String _message = '';

  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

    Future<void> _setCurrentScreen() async {
    await widget.analytics?.setCurrentScreen(
        screenName: 'Notification Page',
      screenClassOverride: 'NotificationPage',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(0)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.headColor,
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Notifications",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: List.generate(usersList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: Offset(0, 1))
                        ],
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(33)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(usersList[index]['img']),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                            child: Container(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Text(
                                  usersList[index]['name'],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 5, height: 0),
                              Expanded(
                                child: Text(usersList[index]['message'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.5)),
                                    overflow: TextOverflow.visible),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
