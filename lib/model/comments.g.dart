// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      comment: json['comment'] as String,
      commentemail: json['commentemail'] as String,
      commentid: json['commentid'] as String,
      commentusername: json['commentusername'] as String,
      commentpostid: json['commentpostid'] as String,
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'comment': instance.comment,
      'commentemail': instance.commentemail,
      'commentid': instance.commentid,
      'commentpostid': instance.commentpostid,
      'commentusername': instance.commentusername,
    };
