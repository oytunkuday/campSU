// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      savedposts: json['savedposts'] as List<dynamic>,
      name: json['name'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      username: json['username'] as String,
      website: json['website'] as String,
      followers: json['followers'] as List<dynamic>,
      following: json['following'] as List<dynamic>,
      posts: json['posts'] as List<dynamic>,
      photoUrl: json['photoUrl'] as String,
      profType: json['profType'] as bool,
    )..geo = json['geo'] == null
        ? null
        : Geo.fromJson(json['geo'] as Map<String, dynamic>);

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'name': instance.name,
      'bio': instance.bio,
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'followers': instance.followers,
      'following': instance.following,
      'posts': instance.posts,
      'website': instance.website,
      'geo': instance.geo,
      'profType': instance.profType,
      'savedposts': instance.savedposts,
    };
