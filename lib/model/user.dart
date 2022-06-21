import 'package:json_annotation/json_annotation.dart';
import 'package:campsu/model/post.dart';
part 'user.g.dart';

@JsonSerializable()
class MyUser {
  String name;
  String bio;
  String username;
  String email;
  String photoUrl;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  String website;
  Geo? geo;
  bool profType;
  List<dynamic> savedposts;

  MyUser({
    required this.savedposts,
    required this.name,
    required this.email,
    required this.bio,
    required this.username,
    required this.website,
    required this.followers,
    required this.following,
    required this.posts,
    required this.photoUrl,
    required this.profType,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
