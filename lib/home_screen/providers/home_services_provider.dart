import 'package:dhanva_mobile_app/global/services/api_services/home_services_api.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:flutter/cupertino.dart';

enum HomeServicesProviderState { loading, done }

class HomeServicesProvider extends ChangeNotifier {
  List<QuickServiceUiModel> _services;
  HomeServicesProviderState _state = HomeServicesProviderState.loading;
  String _errorString;

  List<QuickServiceUiModel> get quickServices => _services;
  bool get isLoading => _state == HomeServicesProviderState.loading;
  bool get hasError => _errorString != null;
  String get error => _errorString;

  void _setQuickServiceLoadingState(HomeServicesProviderState state) {
    _state = state;
    notifyListeners();
  }

  void _setQuickServices(List<QuickServiceUiModel> services) {
    _services = services;
  }

  // void _setLoadingState(HomeServicesProviderState state){
  //   _state = state;
  //   notifyListeners();
  // }

  void _setError(String error) {
    _errorString = error;
  }

  Future<void> fetchServicesList({bool init = false}) async {
    if (!init) _setQuickServiceLoadingState(HomeServicesProviderState.loading);
    List<dynamic> json = await HomeServicesApi.fetchQuickServies();
    List<QuickServiceUiModel> services = List.generate(
        json.length, (int index) => QuickServiceUiModel.fromJson(json[index]));
    _setQuickServices(services);
    _setQuickServiceLoadingState(HomeServicesProviderState.done);
  }
}
