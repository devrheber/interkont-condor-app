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
}
