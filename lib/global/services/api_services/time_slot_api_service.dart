import 'package:dhanva_mobile_app/global/models/date_time_slot.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

class TimeSlotApiService {
  TimeSlotApiService._();

  static const String _allTimeSlotUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.allTImeSlotsApi}';
  static const String _timeSlotByDoctorUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.timeSlotsByDoctorApi}';

  static Future<dynamic> fetchAllTImeSlots() async {
    await SharedPreferenceService.init();
    Response res = await ApiService.dio.get('$_allTimeSlotUri',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    // List<DateTimeSlot> slots = [];
    (res.data as Map<String, dynamic>).entries.forEach((timeSlotData) {
      print('${timeSlotData.key} : ${timeSlotData.value}');
    });
    print(res.data);
    return res.data;
  }

  static Future<dynamic> fetchTimeSlotsByDoctor(String docId) async {
    await SharedPreferenceService.init();
    Response res = await ApiService.dio.get('$_timeSlotByDoctorUri$docId',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    // List<DateTimeSlot> slots = [];
    // (res.data as Map<String, dynamic>).entries.forEach((timeSlotData) {
    //   slots.add(DateTimeSlot.fromSlotDataByDoctor(timeSlotData));
    // });

    return res.data;
  }
}
