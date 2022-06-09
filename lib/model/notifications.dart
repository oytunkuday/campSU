import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:core';


part 'notifications.g.dart';




@JsonSerializable()
class Notifications {
  late String userPhoto;
  late String username;
  late String type;
  late String usermail;
  late String sendermail;
  late String postID;
  late String notificationid;
  late String sendername;
  late String addermail;


  Notifications({
    required this.userPhoto,
    required this.username,
    required this.type,
    required this.sendermail,
    required this.usermail,
    required this.postID,
    required this.notificationid,
    required this.sendername,
    required this.addermail
  });
  

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}