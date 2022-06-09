// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      userPhoto: json['userPhoto'] as String,
      username: json['username'] as String,
      type: json['type'] as String,
      sendermail: json['sendermail'] as String,
      usermail: json['usermail'] as String,
      postID: json['postID'] as String,
      notificationid: json['notificationid'] as String,
      sendername: json['sendername'] as String,
      addermail: json['addermail'] as String,
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'userPhoto': instance.userPhoto,
      'username': instance.username,
      'type': instance.type,
      'usermail': instance.usermail,
      'sendermail': instance.sendermail,
      'postID': instance.postID,
      'notificationid': instance.notificationid,
      'sendername': instance.sendername,
      'addermail': instance.addermail,
    };
