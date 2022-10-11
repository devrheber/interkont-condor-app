import 'package:flutter/foundation.dart';

class QualitativeProgress {
  const QualitativeProgress({
    @required this.aspectToEvaluateId,
    @required this.title,
    @required this.achive,
    @required this.difficulty,
  });
  final int aspectToEvaluateId;
  final String title;
  final String achive;
  final String difficulty;

  factory QualitativeProgress.fromJson(Map<String, dynamic> json) {
    return QualitativeProgress(
        aspectToEvaluateId: json['aspectToEvaluateId'],
        title: json['title'],
        achive: json['achive'],
        difficulty: json['difficulty']);
  }

  Map<String, dynamic> toJson() {
    return {
      'aspectToEvaluateId': aspectToEvaluateId,
      'title': title,
      'achive': achive,
      'difficulty': difficulty
    };
  }
}
