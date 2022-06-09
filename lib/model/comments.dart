
import 'package:json_annotation/json_annotation.dart';
part 'comments.g.dart';




@JsonSerializable()
class Comments {
  String comment;
  String commentemail;
  String commentid;
  String commentpostid;
  String commentusername;


  Comments({
    required this.comment,
    required this.commentemail,
    required this.commentid,
    required this.commentusername,
    required this.commentpostid,


  });

  factory Comments.fromJson(Map<String, dynamic> json) => _$CommentsFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}