import 'package:payments_application/core/helpers/network/api_endpoints.dart';

import '../../../../../../core/helpers/network/network_api_services.dart';
import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';

class PaymentsRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> chkAuthPayStatus() async {
    final _appCacheHelper = AppCacheHelper();
    final _appDecryptHelper = AppEncryptionHelper();
    final _encrptEmpId = await _appCacheHelper.getData("empCode");
    final _decrptEmpId = _appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentAccess}${"10905"}/${1}");
    return response;
  }
  Future<dynamic> chkImpsStatus() async {
    final _appCacheHelper = AppCacheHelper();
    final _appDecryptHelper = AppEncryptionHelper();
    final _encrptEmpId = await _appCacheHelper.getData("empCode");
    final _decrptEmpId = _appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.impsAccess}${"12571"}/${1}");
    return response;
  }
}
