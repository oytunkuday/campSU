import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'notifCard.dart';
import 'notificationClass.dart';


class NotificationPage extends StatefulWidget {
  NotificationPage({Key, key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  List<Object> _notifList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNotifList();
  }

  Future getNotifList() async {
    var data = await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('created', descending: true)
        .get();

    setState(() {
      _notifList = List.from(data.docs.map((doc) => NotificationClass.fromSnapshot(doc)));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Notifications",
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
            itemCount: _notifList.length,
            itemBuilder: (context, index) {
              return NotifCard(_notifList[index] as NotificationClass);
            },
          )
      ),
    );
  }
}