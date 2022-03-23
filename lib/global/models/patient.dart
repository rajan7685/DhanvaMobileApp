import 'package:dhanva_mobile_app/global/models/patient_relation.dart';
import 'package:flutter/foundation.dart';

class Patient {
  final String name;
  final int v;
  final DateTime dob;
  final DateTime createdDateTime;
  final String id;
  final bool enabled;
  final String location;
  final String email;
  final String gender;
  final String maritalStatus;
  final String bloodGroup;
  final String phone;
  final String emergencyContact;
  final double height;
  final double weight;
  final List<PatientRelation> relations;

  Patient(
      {@required this.name,
      @required this.v,
      @required this.dob,
      @required this.createdDateTime,
      @required this.id,
      @required this.enabled,
      @required this.location,
      @required this.email,
      @required this.gender,
      @required this.maritalStatus,
      @required this.bloodGroup,
      @required this.phone,
      @required this.emergencyContact,
      @required this.height,
      @required this.weight,
      @required this.relations});

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        name: json['name'] ?? 'Aniket',
        v: json['__v'] ?? 0,
        dob: json['dob'] ?? DateTime(2000),
        createdDateTime: DateTime.parse(json['created_datetime']),
        id: json['_id'],
        enabled: json['enabled'],
        location: json['latlong'] ?? 'what',
        email: json['email'] ?? 'aniket@regami.solutions',
        gender: json['gender'] ?? 'male',
        maritalStatus: json['marital_status'] ?? 'Single',
        bloodGroup: json['bloodGroup'],
        phone: json['phone'].toString() ?? '8016291431',
        emergencyContact: json['emergency_contact'],
        height: json['height'],
        weight: json['weight'],
        relations: List.generate(
          (json['relation_id'].length),
          (int index) => PatientRelation.fromJson(
            json['relation_id'][index],
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        '__v': v,
        'dob': dob,
        'created_datetime': createdDateTime.toString(),
        '_id': id,
        'enabled': enabled,
        'latlong': location,
        'email': email,
        'gender': gender,
        'marital_status': maritalStatus,
        'bloodGroup': bloodGroup,
        'phone': phone,
        'emergency_contact': emergencyContact,
        'height': height,
        'weight': weight,
        'relation_id': List.generate(
            relations.length, (index) => relations[index].toJson()),
      };
}
