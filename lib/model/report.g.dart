// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reported _$ReportedFromJson(Map<String, dynamic> json) => Reported(
      reportedMail: json['reportedMail'] as String,
      reporterMail: json['reporterMail'] as String,
      postid: json['postid'] as String,
    );

Map<String, dynamic> _$ReportedToJson(Reported instance) => <String, dynamic>{
      'reportedMail': instance.reportedMail,
      'reporterMail': instance.reporterMail,
      'postid': instance.postid,
    };
