import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/widgets.dart';
import 'package:provider/provider.dart';
import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/helpers/session/controller/session_controller.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../model/emp_detail_model.dart';
import '../repository/home_repository.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  HomeProvider() {
    _initialize();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  //transition

  void onEnter(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onExit() {
    selectedIndex = -1;
    notifyListeners();
  }

  void resetItem() {
    selectedIndex = -1;
    curIndex = 0;
    notifyListeners();
  }

//payment status check api
  int selectedIndex = -1;

  int _curIndex = 0;
  int get curIndex => _curIndex;

  set curIndex(int value) {
    _curIndex = value;
  }

  List<Map<String, dynamic>> _homeItems = [];
  List<Map<String, dynamic>> get homeItems => _homeItems;

  List<Map<String, dynamic>> _filteredItems = [];
  List<Map<String, dynamic>> get filteredItems => _filteredItems;

  void _initialize() async {
    // Simulate a delay to mimic data fetching
    await Future.delayed(const Duration(seconds: 2));
    _homeItems = [
      // {
      //   "logo": AssetsPath.home,
      //   "title": "Home",
      //   'route': RoutesPath.home,
      //   "cardColor": AppColor.card1,
      //   "cardTitle": AppColor.card1Title
      // },
      {
        "logo": AssetsPath.debitAdvice,
        "title": "Payments",
        'route': RoutesPath.payments,
        "cardColor": AppColor.card7,
        "cardTitle": AppColor.card7Title
      },
      {
        "logo": AssetsPath.bankRecon,
        "title": "Bank Reconciliation",
        'route': RoutesPath.bankReconciliation,
        "cardColor": AppColor.card5,
        "cardTitle": AppColor.card5Title
      },
      {
        "logo": AssetsPath.bank,
        "title": "SBI",
        'route': RoutesPath.sbi,
        "cardColor": AppColor.card6,
        "cardTitle": AppColor.card6Title
      },

      {
        "logo": AssetsPath.money,
        "title": "OTP Based Cash Withdrawal",
        'route': RoutesPath.otp_based,
        "cardColor": AppColor.card4,
        "cardTitle": AppColor.card4Title
      },
      {
        "logo": AssetsPath.user,
        "title": "Others",
        'route': RoutesPath.others,
        "cardColor": AppColor.card3,
        "cardTitle": AppColor.card3Title
      },
    ];
    _filteredItems = List.from(_homeItems);
    _isLoading = false;
    notifyListeners();
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      _filteredItems = List.from(_homeItems);
    } else {
      _filteredItems = _homeItems
          .where((item) =>
              item["title"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  //handle session

  final _api = HomeRepository();
  Future<void> sessionApi(
      {required BuildContext context, required String curSession}) async {
    try {
      isLoading = true;
      notifyListeners();
      print("call $curSession");
      var data = {"data": curSession.trim()};
      final response = await _api.sessionApi(data);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          final splitted = "${response['data']['response']}".split('|');
          final empCode = splitted[2].split('!');
          final appCacheHelper = AppCacheHelper();
          final appEncryptionHelper = AppEncryptionHelper();
          final encryptEmpCode = appEncryptionHelper.encryptData(
              data: empCode[0].toString(),
              baseKey: EncryptionValue.keyAsString,
              ivKey: EncryptionValue.ivAsString);
          final encryptBranchId = appEncryptionHelper.encryptData(
              data: splitted[0].toString(),
              baseKey: EncryptionValue.keyAsString,
              ivKey: EncryptionValue.ivAsString);
          final encryptBranchName = appEncryptionHelper.encryptData(
              data: splitted[1].toString(),
              baseKey: EncryptionValue.keyAsString,
              ivKey: EncryptionValue.ivAsString);
          appCacheHelper.saveData(key: 'empCode', value: encryptEmpCode);
          appCacheHelper.saveData(key: 'branchID', value: encryptBranchId);
          appCacheHelper.saveData(key: 'branchName', value: encryptBranchName);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed(RoutesName.home);
          });
          notifyListeners();
        } else {
          CustomToast.showCustomToast(message: "Unexpected error occurred");
        }
      } else {
        CustomToast.showCustomToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  var empDetailModel = EmpDetailModel();
  Future<void> employeeDetails() async {
    try {
      final response = await _api.employeeDetails();

      if (response != null && response['status'] == 200) {
        empDetailModel = EmpDetailModel.fromJson(response['data']);
        notifyListeners();
      } else {
        CustomToast.showCustomToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      CustomToast.showCustomToast(
          message: "An error occurred while checking payment status");
    }
  }

  int _loadingIndex = -1;
  int get loadingIndex => _loadingIndex;

  set loadingIndex(int value) {
    _loadingIndex = value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.clear();
  }
}
