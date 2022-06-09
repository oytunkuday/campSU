import 'package:json_annotation/json_annotation.dart';
part 'SearchResults.g.dart';

@JsonSerializable()
class SearchResults {
  String identifier;
  String description;
  String id;
  String photoUrl;

  SearchResults({
    required this.identifier,
    required this.description,
    required this.id,
    required this.photoUrl,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultsToJson(this);
}
