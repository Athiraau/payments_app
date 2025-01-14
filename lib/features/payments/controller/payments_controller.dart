import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/helpers/routes/app_route_name.dart';

import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../model/pay_status_chk_model.dart';
import '../repository/payments_repo.dart';
import '../model/pay_status_chk_model.dart';

class PaymentsProvider extends ChangeNotifier {
  PaymentsProvider() {
    loadingPayments();
  }

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _curIndex = 0;
  int get curIndex => _curIndex;

  // Payment items
  final List<Map<String, dynamic>> _paymentsItems = [
    {
      "logo": AssetsPath.reinitiate,
      "title": "Re-initiate",
      'route': RoutesPath.re_initiate,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.request,
      "title": "Re-initiate Successful\nPayment - Request",
      'route': RoutesPath.re_request,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.approval,
      "title": "Re-initiate Successful\nPayment - Approval",
      'route': RoutesPath.re_approval,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.debitAdvice,
      "title": "Debit Advice Block",
      'route': RoutesPath.debitAdvise,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
    {
      "logo": AssetsPath.succesDebitAdvice,
      "title": "Successful Payment\nto Debit Advice",
      'route': RoutesPath.paymentDebitAdvise,
      "cardColor": AppColor.card5,
      "cardTitle": AppColor.card5Title
    },
    {
      "logo": AssetsPath.changeDebitAdvice,
      "title": "Change Debit Advice Branch",
      'route': RoutesPath.changeDebitAdviseBranch,
      "cardColor": AppColor.card6,
      "cardTitle": AppColor.card6Title
    },
    {
      "logo": AssetsPath.bank,
      "title": "Change Branch IMPS Bank",
      'route': RoutesPath.changeBranchImpsBank,
      "cardColor": AppColor.card7,
      "cardTitle": AppColor.card7Title
    },
    {
      "logo": AssetsPath.pending,
      "title": "Bulk Re-initiate Debit\nAdvice Pending",
      'route': RoutesPath.bulkReinitiate,
      "cardColor": AppColor.card8,
      "cardTitle": AppColor.card8Title
    }
  ];

  // Report items
  final List<Map<String, dynamic>> _reportItem = [
    {
      "logo": AssetsPath.request,
      "title": "Payments Report",
      'route': RoutesPath.paymentReport,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.gold,
      "title": "Payment OGL Report",
      'route': RoutesPath.paymentOglReport,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.daReport,
      "title": "Debit Advice Report",
      'route': RoutesPath.paymentDebitAdviseReport,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.status,
      "title": "Payment Status",
      'route': RoutesPath.paymentStatus,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
    {
      "logo": AssetsPath.inquiry,
      "title": "IMPS Inquiry",
      'route': RoutesPath.impsInquiry,
      "cardColor": AppColor.card5,
      "cardTitle": AppColor.card5Title
    },
    {
      "logo": AssetsPath.debitAdvice,
      "title": "Customer NEFT Details",
      'route': RoutesPath.neftDeatils,
      "cardColor": AppColor.card6,
      "cardTitle": AppColor.card6Title
    },
  ];

  List<Map<String, dynamic>> get paymentsItems => _paymentsItems;
  List<Map<String, dynamic>> get reportItem => _reportItem;

  List<Map<String, dynamic>> _filteredItems = [];
  List<Map<String, dynamic>> get filteredItems => _filteredItems;

  Future<void> loadingPayments() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _isLoading = false;
      loadPaymentsItem();
      notifyListeners();
    });
  }

  setTabIndex(int index) async {
    _curIndex = index;
    if (_curIndex == 0) {
      loadPaymentsItem();
    } else {
      loadReportItem();
    }
    notifyListeners();
  }

  void searchItems(String query) {
    List<Map<String, dynamic>> sourceList =
        _curIndex == 0 ? paymentsItems : reportItem;

    if (query.isEmpty) {
      _filteredItems = List.from(sourceList);
    } else {
      _filteredItems = sourceList
          .where((item) => item['title']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void loadPaymentsItem() {
    _filteredItems = List.from(paymentsItems);
    notifyListeners();
  }

  void loadReportItem() {
    _filteredItems = List.from(reportItem);
    notifyListeners();
  }

  //branch name

//payment status check api
  final _api = PaymentsRepository();
  var payStatusChkModel = PayStatusChkModel();
  Future<void> chkAuthPayStatus({required BuildContext context}) async {
    try {
      final response = await _api.chkAuthPayStatus();

      if (response != null && response['status'] == 200) {
        payStatusChkModel = PayStatusChkModel.fromJson(response['data']);
        final splitResponse = payStatusChkModel.response!.first.rES!.split('~');

        // final splitResponse = response['data']['response'][0]['RES'].split('~');

        final shouldNavigate = splitResponse[0].toString() == "0" ||
            splitResponse[1].toString() == "1";

        notifyListeners();

        if (shouldNavigate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomAlertDialog.showCustomAlertDialog(
              context: context,
              title: 'Unauthorized',
              message: splitResponse[1].toString(),
              confirmText: 'Confirm',
              cancelText: 'Cancel',
              isActionTrue: false,
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed(RoutesName.paymentStatus);
          });
        }
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
    } finally {
      notifyListeners();
    }
  }
}
