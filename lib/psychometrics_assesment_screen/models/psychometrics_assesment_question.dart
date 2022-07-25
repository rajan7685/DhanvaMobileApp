import 'package:flutter/cupertino.dart';

class PsychometricsAssesmentQuestion {
  PsychometricsAssesmentQuestion(
      {@required this.question, @required this.options});

  final String question;
  final List<String> options;

  factory PsychometricsAssesmentQuestion.fromJsonData(
          Map<String, dynamic> json) =>
      PsychometricsAssesmentQuestion(
          options: json['options'], question: json['question']);
}
