// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      username: json['username'] as String,
      website: json['website'] as String,
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
      connections: (json['connections'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bio': instance.bio,
      'username': instance.username,
      'email': instance.email,
      'website': instance.website,
      'connections': instance.connections,
      'geo': instance.geo,
    };
