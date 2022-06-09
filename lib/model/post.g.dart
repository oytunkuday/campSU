// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geo _$GeoFromJson(Map<String, dynamic> json) => Geo(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

JsonPost _$JsonPostFromJson(Map<String, dynamic> json) => JsonPost(
      username: json['username'] as String,
      postid: json['postid'] as String,
      email: json['email'] as String,
      date: DateTime.parse(json['date'] as String),
      comments: json['comments'] as List<dynamic>,
      likes: json['likes'] as List<dynamic>,
      content: json['content'] as String,
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
      Liked: json['Liked'] as bool? ?? false,
      postPhotoUrl: json['postPhotoUrl'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String,
    );

Map<String, dynamic> _$JsonPostToJson(JsonPost instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'date': instance.date.toIso8601String(),
      'userPhotoUrl': instance.userPhotoUrl,
      'postPhotoUrl': instance.postPhotoUrl,
      'comments': instance.comments,
      'likes': instance.likes,
      'content': instance.content,
      'geo': instance.geo,
      'Liked': instance.Liked,
      'postid': instance.postid,
    };
