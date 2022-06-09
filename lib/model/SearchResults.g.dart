// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchResults.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResults _$SearchResultsFromJson(Map<String, dynamic> json) =>
    SearchResults(
      identifier: json['identifier'] as String,
      description: json['description'] as String,
      id: json['id'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$SearchResultsToJson(SearchResults instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'description': instance.description,
      'id': instance.id,
      'photoUrl': instance.photoUrl,
    };
