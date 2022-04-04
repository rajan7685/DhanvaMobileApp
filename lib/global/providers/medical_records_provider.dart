import 'package:dhanva_mobile_app/global/models/medical_record.dart';
import 'package:dhanva_mobile_app/global/services/api_services/medical_records_service.dart';
import 'package:flutter/cupertino.dart';

enum _MeidcalRecordsloadingState { loading, ready }

class MedicalRecordsProvider extends ChangeNotifier {
  List<MedicalRecord> _records;
  _MeidcalRecordsloadingState _recordsLoadingState =
      _MeidcalRecordsloadingState.loading;

  // getters
  List<MedicalRecord> get medicalRecords => _records;
  bool get isMedicalRecordsLoading =>
      _recordsLoadingState == _MeidcalRecordsloadingState.loading;

  void _setMeidcalRecordsloadingState(_MeidcalRecordsloadingState state) {
    _recordsLoadingState = state;
    notifyListeners();
  }

  void _setMedicalRecords(List<MedicalRecord> records) {
    _records = records;
  }

  // network call handlers
  Future<void> fetchMedicalRecords({bool init = false}) async {
    if (!init)
      _setMeidcalRecordsloadingState(_MeidcalRecordsloadingState.loading);
    List<dynamic> jsonData = await MedicalRecordsService.fetchMedicalRecords();
    List<MedicalRecord> records = List.generate(jsonData.length,
        (int index) => MedicalRecord.fromJson(jsonData[index]));
    _setMedicalRecords(records);
    _setMeidcalRecordsloadingState(_MeidcalRecordsloadingState.ready);
  }
}
