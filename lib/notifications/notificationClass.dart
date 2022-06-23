class NotificationClass {
  String message;
  DateTime created;
  String targetEmail;

  NotificationClass({
    required this.message,
    required this.created,
    required this.targetEmail,
  });

  Map<String, dynamic> toJason() =>
      {'message': message, 'created': created, 'targetEmail': targetEmail};
  NotificationClass.fromSnapshot(snapshot)
      : message = snapshot.data()['message'],
        targetEmail = snapshot.data()['targetEmail'],
        created = snapshot.data()['created'].toDate();
}
