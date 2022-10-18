import 'package:flutter/foundation.dart';

class QualitativeProgress {
  const QualitativeProgress({
    @required this.aspectToEvaluateId,
    @required this.title,
    this.achive,
    this.difficulty,
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

  String get getAchive {
    if (achive == null || achive.isEmpty) {
      return '---';
    }

    return achive;
  }

  String get getDifficulty {
    if (difficulty == null || difficulty.isEmpty) {
      return '---';
    }

    return difficulty;
  }
}
