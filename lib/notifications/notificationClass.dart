class NotificationClass {

  String message;
  DateTime created;

  NotificationClass({
    required this.message,
    required this.created,
  });

  Map<String, dynamic> toJason() => {'message': message, 'created' : created};
  NotificationClass.fromSnapshot(snapshot)
      : message = snapshot.data()['message'],
        created = snapshot.data()['created'].toDate();

}