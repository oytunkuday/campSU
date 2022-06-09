
import 'package:json_annotation/json_annotation.dart';
part 'report.g.dart';




@JsonSerializable()
class Reported {
  late String reportedMail;
  late String reporterMail;
  late String postid;


  Reported({
    required this.reportedMail,
    required this.reporterMail,
    required this.postid,
  


  });

  factory Reported.fromJson(Map<String, dynamic> json) => _$ReportedFromJson(json);
  Map<String, dynamic> toJson() => _$ReportedToJson(this);
}