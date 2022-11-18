import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/services/api_services/doctors_details_service.dart';
import 'package:flutter/cupertino.dart';

class DoctorRecordProvider extends ChangeNotifier {
  List<Doctor> _doctors;
  String _errorText;
  bool _hasError = false;
  bool _isLoading = true;

  // getters
  List<Doctor> get doctors => _doctors;
  bool get isLoading => _isLoading;

  void _setLoadingState(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  void _setDoctorsList(List<Doctor> doctors) {
    _doctors = doctors;
  }

  Future<dynamic> fetchAllDoctors(
      {@required String hospitalId,
      @required String serviceId,
      bool init = false}) async {
    if (!init) _setLoadingState(true);
    List<dynamic> jsonData = await DoctorDetailsService.fetchAllDoctors(
        hospitalId: hospitalId, serviceId: serviceId);
    List<Doctor> doctors = List.generate(
        jsonData.length, (int index) => Doctor.fromJson(jsonData[index]));
    _setDoctorsList(doctors);
    _setLoadingState(false);
  }
}
