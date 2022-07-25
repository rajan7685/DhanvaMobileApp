import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

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

  static Future<dynamic> downloadFile({@required String fileUri}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String savePath = 'MedicalRecords/';
    fileUri =
        'https://dhanva-files.s3.us-west-2.amazonaws.com/users/61a3b2258cf6bbf875e00ab7/6gdh6_Screenshot 2021-12-08 185523.png';
    Response<dynamic> file = await ApiService.dio.download(
        fileUri,
        appDocDir.path +
            '/' +
            savePath +
            fileUri.split('/')[fileUri.split('/').length - 1]);
  }
}
