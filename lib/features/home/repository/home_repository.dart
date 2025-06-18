
import '../../../../../../core/helpers/network/network_api_services.dart';
import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/network/api_endpoints.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> sessionApi(var data) async {
    dynamic response = await _apiService.postApi(data, ApiEndPoints.portaleURL);
    return response;
  }

  Future<dynamic> employeeDetails() async {
    final _appCacheHelper = AppCacheHelper();
    final _appDecryptHelper = AppEncryptionHelper();
    final _encrptEmpId = await _appCacheHelper.getData("empCode");
    final _decrptEmpId = _appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.empDetails}$_decrptEmpId/${1}");
    return response;
  }
}
