import 'package:dio/dio.dart';

class ApiService {
  ApiService._();

  static const String protocol = 'http://';
  static const String baseUrl = 'api3.dhanva.icu/';
  static const String loginApi = 'otp/otpLogin/';
  static const String otpVerificationApi = 'otp/otpVerify/';
  static const String servicesApi = 'services/get/';

  /// +@PatientId required
  /// files/docs/{PatientId}
  static const String medicalRecordsApi = 'files/docs/';
  static const String upcomingMedicalAppointmentsApi = 'appointment/upcoming/';
  static const String allDoctorsApi = 'employee/doctor/all/'; //+docID
  static const String allTImeSlotsApi = 'appointment/get_all_time_slots';

  /// +@docId required
  /// appointment/get_time_slots/{docId}
  static const String timeSlotsByDoctorApi = 'appointment/get_time_slots/';
  static Dio dio = Dio();
}
