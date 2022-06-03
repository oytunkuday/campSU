
import 'package:json_annotation/json_annotation.dart';
import 'package:campsu/model/post.dart';
part 'user.g.dart';




@JsonSerializable()
class MyUser {
  int id;
  String name;
  String bio;
  String username;
  String email;
  String website;
  List<String> connections;
  Geo geo;



  MyUser({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
    required this.username,
    required this.website,
    required this.geo,
    required this.connections,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}