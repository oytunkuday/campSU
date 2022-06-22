class UsersClass {

  String username;

  UsersClass({
    required this.username,
  });

  Map<String, dynamic> toJason() => {'username': username};
  UsersClass.fromSnapshot(snapshot)
      : username = snapshot.data()['username'];

}