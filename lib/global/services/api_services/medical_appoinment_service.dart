import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/medical_appointment.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

class MedicalAppointmentsService {
  MedicalAppointmentsService._();
  static final String _medicalAppointmentsUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.upcomingMedicalAppointmentsApi}';

  static Future<void> fetchMedicalAppointments() async {
    await SharedPreferenceService.init();
    Patient p = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get('$_medicalAppointmentsUri${p.id}',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    print(res.data[0]['patient_id'].runtimeType);
    // MedicalAppointment app = MedicalAppointment.fromJson(res.data[0]);
    // print(app.doctor.name);
    return res.data;
  }
}
