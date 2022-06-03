import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:core';

part 'post.g.dart';

class Post {
  String owner;
  String text;
  String date;
  List<String> comments;
  List<String> likes;
  int likecount;
  var content;
  Geo geo;

  Post(
      {required this.owner,
      required this.text,
      required this.date,
      required this.comments,
      required this.likecount,
      required this.likes,
      required this.content,
      required this.geo});
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
  String owner;
  String text;
  String date;
  List<String> comments;
  int likecount;
  List<String> likes;
  var content;
  Geo geo;

  @JsonKey(defaultValue: 0)
  int userId;

  @JsonKey(name: 'id')
  int postId;

  JsonPost(
      {required this.owner,
      required this.text,
      required this.date,
      required this.comments,
      required this.likecount,
      required this.likes,
      required this.content,
      required this.userId,
      required this.postId,
      required this.geo});

  factory JsonPost.fromJson(Map<String, dynamic> json) =>
      _$JsonPostFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPostToJson(this);
}
