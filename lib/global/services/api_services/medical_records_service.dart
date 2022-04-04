import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

class MedicalRecordsService {
  MedicalRecordsService._();

  static final String _medicalRecordsUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.medicalRecordsApi}';

  static Future<List<dynamic>> fetchMedicalRecords(
      {String patientId = ''}) async {
    await SharedPreferenceService.init();
    Patient p = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get('$_medicalRecordsUri${p.id}',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    return res.data;
  }
}
