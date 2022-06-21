import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:core';

part 'post.g.dart';

class Post {
  String username;
  String postid;
  String email;
  DateTime date;
  String userPhotoUrl;
  String postPhotoUrl;
  List<dynamic> comments;
  List<dynamic> likes;
  String content;
  Geo? geo;
  bool Liked;
  Post(

      {required this.username,
      required this.postid,
      required this.email,
      required this.date,
      required this.comments,
      required this.likes,
      required this.content,
      this.Liked=false,
      required this.postPhotoUrl,
      required this.userPhotoUrl,
      });
}

@JsonSerializable()
class Geo {
  String lat;
  String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
  Map<String, dynamic> toJson() => _$GeoToJson(this);
}

@JsonSerializable()
class JsonPost {
  String username;
  String email;
  DateTime date;
  String userPhotoUrl;
  String postPhotoUrl;
  List<dynamic> comments;
  List<dynamic> likes;
  String content;
  Geo? geo;
  bool Liked;


  @JsonKey()
  String postid;

  JsonPost(
      {required this.username,
      required this.postid,
      required this.email,
      required this.date,
      required this.comments,
      required this.likes,
      required this.content,
      this.Liked=false,
      required this.postPhotoUrl,
      required this.userPhotoUrl,});

  factory JsonPost.fromJson(Map<String, dynamic> json) =>
      _$JsonPostFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPostToJson(this);
}
