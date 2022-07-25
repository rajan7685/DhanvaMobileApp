import 'dart:convert';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/log_in_out_api.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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
    // print(SharedPreferenceService.loadString(key: AuthTokenKey));
    _setAuthTokenKey(SharedPreferenceService.loadString(key: AuthTokenKey));
    String patientJson = SharedPreferenceService.loadString(key: PatientKey);
    if (patientJson != null)
      _setPatient(Patient.fromJson(jsonDecode(patientJson)));
    notifyListeners();
  }

  AuthenticationProvider._create() {
    _initiateDataStorage();
  }

  static AuthenticationProvider get instance {
    if (_instance == null) {
      _instance = AuthenticationProvider._create();
    }
    // await _instance._initiateDataStorage();
    return _instance;
  }

  // getters
  Patient get patient => _patient;
  bool get hasError => _errorString != null;
  String get error => _errorString;
  String get authToken => SharedPreferenceService.loadString(key: AuthTokenKey);
  bool get isReady => _state == AuthenticationProviderState.done;

  void _setAuthTokenKey(String token) {
    _authToken = token;
    // notifyListeners();
  }

  void _setPatient(Patient p) {
    _patient = p;
    // notifyListeners();
  }

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
      // print('$mobile $otp');
      Map<String, dynamic> jsonData =
          await LoginApiService.verifyLogin(mobile: mobile, otp: otp);
      SharedPreferenceService.saveString(
          key: AuthTokenKey, value: jsonData['token']);
      _authToken = jsonData['token'];
      SharedPreferenceService.saveString(
          key: PatientKey, value: jsonEncode(jsonData['patient']));
      _patient = Patient.fromJson(jsonData['patient']);
      return 'success';
    } on DioError catch (error) {
      print('error authprov : ${error.toString()}');
      return 'incorrect otp';
    } catch (e, s) {
      print('error authprov : ${e.toString()} $s');
      return 'An unexpected error occured';
    }
  }
}
