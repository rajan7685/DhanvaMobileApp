import 'package:dhanva_mobile_app/global/models/date_time_slot.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

class TimeSlotApiService {
  TimeSlotApiService._();

  static String _allTimeSlotUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.allTimeSlotsApi}${SharedPreferenceService.loadString(key: OnlineHospitalKey)}';
  static const String _timeSlotByDoctorUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.timeSlotsByDoctorApi}';

  static Future<dynamic> fetchAllTImeSlots() async {
    print("_allTimeSlotUri $_allTimeSlotUri");
    await SharedPreferenceService.init();
    Response res = await ApiService.dio.get('$_allTimeSlotUri',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    return res.data;
  }

  static Future<dynamic> fetchTimeSlotsByDoctor(
      String hospitalId, String docId) async {
    await SharedPreferenceService.init();
    print('$_timeSlotByDoctorUri$hospitalId/$docId');
    Response res = await ApiService.dio.get(
        '$_timeSlotByDoctorUri$hospitalId/$docId',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    return res.data;
  }
}
