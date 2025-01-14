import 'package:payments_application/core/helpers/network/api_endpoints.dart';

import '../../../../../../core/helpers/network/network_api_services.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> sessionApi(var data) async {
    dynamic response = await _apiService.postApi(data, ApiEndPoints.portaleURL);
    return response;
  }
}
