import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dio/dio.dart';

class LoginApiService {
  LoginApiService._();

  static final String _loginUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.loginApi}';
  static final String _verifyLoginUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.otpVerificationApi}';

  static Future<Map<String, dynamic>> attemptLogin(
      {String mobile = '8016291431', String fcm}) async {
    Response res =
        await ApiService.dio.post(_loginUri, data: {'phone': mobile, if(fcm != null) "fcm_token" : fcm});
    // Map<String, dynamic> jsonData = jsonDecode(res.data);
    // print('$jsonData ${jsonData.runtimeType}');
    return res.data;
  }

  static Future<Map<String, dynamic>> verifyLogin(
      {String mobile, String otp}) async {
    Response res = await ApiService.dio
        .post(_verifyLoginUri, data: {'phone': mobile, 'otp': otp});
    return res.data;
  }
}
