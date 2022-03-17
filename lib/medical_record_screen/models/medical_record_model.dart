import 'package:flutter/cupertino.dart';

class MedicalRecordModel {
  final String recordId;
  final String recordTitle;
  final String patientName;
  final String doctorName;
  final String relationType;
  final DateTime dateTime;
  final List<String> pdfLinks;

  MedicalRecordModel(
      {@required this.patientName,
      @required this.doctorName,
      @required this.dateTime,
      @required this.recordTitle,
      @required this.pdfLinks,
      @required this.relationType,
      @required this.recordId});

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) =>
      MedicalRecordModel(
          relationType: json['relation_type'],
          doctorName: json['doctor_name'],
          recordTitle: json['record_title'],
          recordId: json['record_id'],
          pdfLinks: json['pdf_links'],
          patientName: json['patient_name'],
          dateTime: json['time']);

  Map<String, dynamic> toJson() => {
        "record_id": this.recordId,
        "patient_name": this.patientName,
        "pdf_links": this.pdfLinks,
        "relation_type": this.relationType,
        "time": this.dateTime,
        "doctor_name": this.doctorName,
        "record_title": this.recordTitle,
      };
}
