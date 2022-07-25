import 'package:flutter/cupertino.dart';

class MedicalRecord {
  String patientId;
  String employeeId;
  String attachmentId;
  String id;
  String fileName;
  String docType;
  String filePath;
  DateTime createdAt;
  int v;

  MedicalRecord(
      {@required this.patientId,
      @required this.employeeId,
      @required this.attachmentId,
      @required this.id,
      @required this.fileName,
      @required this.docType,
      @required this.filePath,
      @required this.createdAt,
      @required this.v});

  MedicalRecord.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    employeeId = json['employee_id'];
    attachmentId = json['attachment_id'];
    id = json['_id'];
    fileName = json['fileName'];
    docType = json['docType'];
    filePath = json['filePath'];
    createdAt = DateTime.parse(json['createdAt']);
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['employee_id'] = this.employeeId;
    data['attachment_id'] = this.attachmentId;
    data['_id'] = this.id;
    data['fileName'] = this.fileName;
    data['docType'] = this.docType;
    data['filePath'] = this.filePath;
    data['createdAt'] = this.createdAt.toString();
    data['__v'] = this.v;
    return data;
  }
}
