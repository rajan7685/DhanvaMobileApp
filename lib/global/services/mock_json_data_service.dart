import 'package:dhanva_mobile_app/appointments_screen/appointment_model.dart';
import 'package:flutter/services.dart' as FlutterServices;
import 'dart:convert' as DartConvert;

class MockJsonDataService {
  static Future<List<AppointmentModel>> readAppointmentJsonData() async {
    String dataString = await FlutterServices.rootBundle
        .loadString('assets/json/appointments_mock.json');

    Map<String, dynamic> jsonData = DartConvert.jsonDecode(dataString);
    print(jsonData['appointments'].length);
    List<AppointmentModel> dataModel = List.generate(
        jsonData['appointments'].length,
        (index) => AppointmentModel.fromJson(jsonData['appointments'][index]));
    // print(dataModel);
    return dataModel;
  }

  static Future<dynamic> readMedicalRecordJsonData() async {
    String dataString = await FlutterServices.rootBundle
        .loadString('assets/json/medical_record_mock.json');
    print(dataString);
  }
}
