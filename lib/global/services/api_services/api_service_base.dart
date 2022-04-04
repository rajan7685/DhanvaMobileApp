import 'package:dio/dio.dart';

class ApiService {
  ApiService._();

  static const String protocol = 'http://';
  static const String baseUrl = '13.126.148.173:8420/';
  static const String loginApi = 'otp/otpLogin/';
  static const String otpVerificationApi = 'otp/otpVerify/';
  static const String servicesApi = 'services/get/';
  static const String medicalRecordsApi = 'files/docs/'; // +id
  static Dio dio = Dio();
}
