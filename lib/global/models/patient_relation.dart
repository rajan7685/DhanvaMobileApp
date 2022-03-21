import 'package:flutter/foundation.dart';

class PatientRelation {
  final String type;
  final String id;
  final String patientId;
  final String patientName;
  final DateTime createdDateTime;
  final int v;

  PatientRelation(
      {@required this.type,
      @required this.id,
      @required this.patientId,
      @required this.patientName,
      @required this.createdDateTime,
      @required this.v});

  factory PatientRelation.fromJson(Map<String, dynamic> json) =>
      PatientRelation(
          type: json['type'],
          id: json['_id'],
          patientId: json['user']['_id'],
          patientName: json['user']['name'],
          createdDateTime: DateTime.parse(json['created_datetime']),
          v: json['__v']);
}
