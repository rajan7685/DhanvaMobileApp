import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/log_in_out_api.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:flutter/cupertino.dart';

// import these two lines to use this provider
// ChangeNotifierProvider<AuthenticationProvider> authProvider =
//     ChangeNotifierProvider((ref) => AuthenticationProvider.instance);

enum AuthenticationProviderState { trying, done }

class AuthenticationProvider extends ChangeNotifier {
  Patient _patient;
  String _authToken;
  AuthenticationProviderState _state = AuthenticationProviderState.trying;
  String _errorString;

  // singleton
  static AuthenticationProvider _instance;

  Future<void> _initiateDataStorage() async {
    await SharedPreferenceService.init();
    _authToken = SharedPreferenceService.loadString(key: AuthTokenKey);
    String patientJson = SharedPreferenceService.loadString(key: PatientKey);
    if (patientJson != null)
      _patient = Patient.fromJson(jsonDecode(patientJson));
  }

  AuthenticationProvider._create() {
    _initiateDataStorage();
  }

  static AuthenticationProvider get instance {
    if (_instance == null) {
      _instance = AuthenticationProvider._create();
    }
    return _instance;
  }

  // getters
  Patient get patient => _patient;
  bool get hasError => _errorString != null;
  String get error => _errorString;
  String get authToken => _authToken;
  bool get isReady => _state == AuthenticationProviderState.done;

  // change lading status
  void changeLoadingState(AuthenticationProviderState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> attemptLogin({@required String mobile}) async {
    await LoginApiService.attemptLogin(mobile: mobile);
  }

  Future<String> verifyLoginOtp(
      {@required String mobile, @required String otp}) async {
    try {
      Map<String, dynamic> jsonData =
          await LoginApiService.verifyLogin(mobile: mobile, otp: otp);
      SharedPreferenceService.saveString(
          key: AuthTokenKey, value: jsonData['token']);
      _authToken = jsonData['token'];
      SharedPreferenceService.saveString(
          key: PatientKey, value: jsonEncode(jsonData['patient']));
      _patient = Patient.fromJson(jsonData['patient']);
      return 'success';
    } catch (e) {
      print('error authprov : ${e.toString()}');
      return 'incorrect otp';
    }
  }
}
