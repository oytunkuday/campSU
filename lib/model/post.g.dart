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
      owner: json['owner'] as String,
      text: json['text'] as String,
      date: json['date'] as String,
      comments:
          (json['comments'] as List<dynamic>).map((e) => e as String).toList(),
      likecount: json['likecount'] as int,
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      content: json['content'],
      userId: json['userId'] as int? ?? 0,
      postId: json['id'] as int,
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonPostToJson(JsonPost instance) => <String, dynamic>{
      'owner': instance.owner,
      'text': instance.text,
      'date': instance.date,
      'comments': instance.comments,
      'likecount': instance.likecount,
      'likes': instance.likes,
      'content': instance.content,
      'geo': instance.geo,
      'userId': instance.userId,
      'id': instance.postId,
    };
