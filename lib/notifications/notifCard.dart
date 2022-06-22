import 'package:flutter/material.dart';

import 'notificationClass.dart';

class NotifCard extends StatelessWidget {

  final NotificationClass _notification;

  NotifCard(this._notification);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: myNotification(_notification.message),
    );
  }
}

Widget infoNotification(String message){
  return Container(
    color: const Color(0xAACCCCCC),
    height: 70,
    width: double.infinity,
    child: Row(
      children:[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget myNotification(String message){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      child: Column(
        children: [
          infoNotification(message),
        ],
      ),
    ),
  );
}