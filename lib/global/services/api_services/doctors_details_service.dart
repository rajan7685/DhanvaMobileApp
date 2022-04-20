import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

class DoctorDetailsService {
  DoctorDetailsService._();
  static final String _allDoctorsUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.allDoctorsApi}';

  static Future<List<dynamic>> fetchAllDoctors() async {
    await SharedPreferenceService.init();
    Patient p = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get('$_allDoctorsUri',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    List<Doctor> doctors = List.generate(
        res.data.length, (int index) => Doctor.fromJson(res.data[index]));
    print(doctors);
    return res.data;
  }
}
