import 'package:dio/dio.dart';

class ApiService {
  ApiService._();

  static const String protocol = 'http://';
  static const String baseUrl = 'api3.dhanva.icu/';
  static const String loginApi = 'otp/otpLogin/';
  static const String otpVerificationApi = 'otp/otpVerify/';
  static const String servicesApi = 'services/get/';
  static const String medicalRecordsApi = 'files/docs/'; // +id
  static const String upcomingMedicalAppointmentsApi = 'appointment/upcoming/';
  static const String allDoctorsApi = 'employee/doctor/all/'; //+docID
  static Dio dio = Dio();
}
