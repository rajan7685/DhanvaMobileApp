import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dio/dio.dart';

class PatientApiService {
  PatientApiService._();
  static final String _patientRelationsUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.patientRelationsApi}';

  static Future<dynamic> fetchPatientRelations(String patientId) async {
    Response res = await ApiService.dio.get('$_patientRelationsUri$patientId');
  }
}
