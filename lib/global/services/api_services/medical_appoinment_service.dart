import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/medical_appointment.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MedicalAppointmentsService {
  MedicalAppointmentsService._();
  static final String _medicalAppointmentsUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.upcomingMedicalAppointmentsApi}';

  static Future<dynamic> fetchMedicalAppointments(String patientId) async {
    await SharedPreferenceService.init();
    Response res = await ApiService.dio.get(
        '$_medicalAppointmentsUri$patientId',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    return res.data;
  }
}
