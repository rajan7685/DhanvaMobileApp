import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

class HomeServicesApi {
  HomeServicesApi._();

  static final String _quickServicesUri =
      '${ApiService.protocol}${ApiService.baseUrl}${ApiService.servicesApi}';

  static Future<List<dynamic>> fetchQuickServies() async {
    await SharedPreferenceService.init();
    Response res = await ApiService.dio.get(_quickServicesUri,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    return res.data;
  }
}
