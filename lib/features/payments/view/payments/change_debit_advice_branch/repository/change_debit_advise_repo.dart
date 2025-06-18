import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/api_endpoints.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class ChangeDebitAdviseRepo {
  final _apiService = NetworkApiServices();
  final appDecryptHelper = AppEncryptionHelper();
  final appCacheHelper = AppCacheHelper();

  ///Branch dropdown
  Future<dynamic> fetchBranch() async {
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "BRANCH_CHANGE_GET_BRANCHES";
    String p_paraval = "1";
    dynamic response = await _apiService
        .getApi("${ApiEndPoints.baseURL}$p_flag/$p_pageval/$p_paraval");
    return response;
  }

  ///Document id dropdown
  Future<dynamic> fetchDocument({String? branchId}) async {
    final p_pageval = branchId;
    String p_flag = "BRANCH_CHANGE_GET_DOCUMENTS";
    String p_paraval = "1";
    dynamic response = await _apiService
        .getApi("${ApiEndPoints.baseURL}$p_flag/$p_pageval/$p_paraval");
    return response;
  }

  ///Fetch table data
  Future<dynamic> fetchTableData({String? corId}) async {
    final p_pageval = corId;
    String p_flag = "BRANCH_CHANGE_TABLE_DATA";
    String p_paraval = "1";
    dynamic response = await _apiService
        .getApi("${ApiEndPoints.baseURL}$p_flag/$p_pageval/$p_paraval");
    return response;
  }

  ///NewBranch dropdown
  Future<dynamic> fetchNewBranch({String? branchId}) async {
    final p_pageval = branchId;
    String p_flag = "BRANCH_CHANGE_GET_NEW_BRANCHES";
    String p_paraval = "1";
    dynamic response = await _apiService
        .getApi("${ApiEndPoints.baseURL}$p_flag/$p_pageval/$p_paraval");
    return response;
  }

  ///Update data
  Future<dynamic> updateChangeDebitAdviseBranch({
    String? oldBranchId,
    String? newBranchId,
    String? corId,
  }) async {
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final userId = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    final curNewBranchId = newBranchId!.split('-');
    final curCorId = corId!.split('-');
    final p_pageval =
        "$oldBranchId*${curNewBranchId[0].trim()}*$userId*${curCorId[1].trim()}";
    String p_flag = "BRANCH_CHANGE_UPDATE_BRANCH";
    String p_paraval = "1";
    dynamic response = await _apiService
        .getApi("${ApiEndPoints.baseURL}$p_flag/$p_pageval/$p_paraval");
    return response;
  }
}
