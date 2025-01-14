import 'package:flutter/material.dart';

import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';

class OtpBasedProvider extends ChangeNotifier {
  OtpBasedProvider() {
    loadingPayments();
  }

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _curIndex = 0;
  int get curIndex => _curIndex;

  // Payment items
  final List<Map<String, dynamic>> _registrationItems = [
    {
      "logo": AssetsPath.verify,
      "title": "Verification",
      'route': RoutesPath.verification,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.download,
      "title": "Beneficiary Download",
      'route': RoutesPath.beneficiary_download,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.upload,
      "title": "Beneficiary Upload",
      'route': RoutesPath.beneficial_upload,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.user,
      "title": "Remove Registration",
      'route': RoutesPath.remove_registration,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
  ];

  // Report items
  final List<Map<String, dynamic>> _fundTransfer = [
    {
      "logo": AssetsPath.approval,
      "title": "Approval",
      'route': RoutesPath.approval,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.gold,
      "title": "CGM/SGM Approval",
      'route': RoutesPath.cgm_sgm_approval,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.updations,
      "title": "CRN Updation",
      'route': RoutesPath.crn_updation,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.upload,
      "title": "MIS File Upload",
      'route': RoutesPath.mis_file_upload,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
  ];

  final List<Map<String, dynamic>> _reportItem = [
    {
      "logo": AssetsPath.report1,
      "title": "Registration Report",
      'route': RoutesPath.registration_report,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.report2,
      "title": "Transaction Report",
      'route': RoutesPath.transaction_report,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.request,
      "title": "CRN Excel Report",
      'route': RoutesPath.crn_excel_report,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.status,
      "title": "Live Employee Report",
      'route': RoutesPath.live_employee_report,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    }
  ];

  List<Map<String, dynamic>> get registrationItems => _registrationItems;
  List<Map<String, dynamic>> get fundTransferItem => _fundTransfer;
  List<Map<String, dynamic>> get reportItem => _reportItem;

  List<Map<String, dynamic>> _filteredItems = [];
  List<Map<String, dynamic>> get filteredItems => _filteredItems;

  Future<void> loadingPayments() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _isLoading = false;
      loadRegistrationItem();
      notifyListeners();
    });
  }

  void setTabIndex(int index) {
    _curIndex = index;
    if (_curIndex == 0) {
      loadRegistrationItem();
    } else if (_curIndex == 1) {
      loadFundTransItem();
    } else {
      loadReportItem();
    }
    notifyListeners();
  }

  void searchItems(String query) {
    List<Map<String, dynamic>> sourceList =
        _curIndex == 0 ? registrationItems : fundTransferItem;

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

  void loadRegistrationItem() {
    _filteredItems = List.from(registrationItems);
    notifyListeners();
  }

  void loadReportItem() {
    _filteredItems = List.from(reportItem);
    notifyListeners();
  }

  void loadFundTransItem() {
    _filteredItems = List.from(fundTransferItem);
    notifyListeners();
  }
}
