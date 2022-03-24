import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

//key constansts
const String PatientKey = 'PatientData';
const String AuthTokenKey = 'AuthToken';

class SharedPreferenceService {
  SharedPreferenceService._();

  static SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(
      {@required String key, @required String value}) async {
    return await _prefs.setString(key, value);
  }

  static String loadString({@required String key}) {
    return _prefs.getString(key);
  }
}
