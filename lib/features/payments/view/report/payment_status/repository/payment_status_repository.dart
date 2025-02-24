import 'package:payments_application/core/helpers/network/api_endpoints.dart';

import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class PaymentStatusRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> fetchPayStatusData(
      {required String ckBoxId, required String id}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentData}$ckBoxId*$id/1");
    return response;
  }

  Future<dynamic> chkRRNumStatus() async {
    final _appCacheHelper = AppCacheHelper();
    final _appDecryptHelper = AppEncryptionHelper();
    final _encrptEmpId = await _appCacheHelper.getData("empCode");
    final _decrptEmpId = _appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentRadio}${"11916"}/1");
    return response;
  }
}
