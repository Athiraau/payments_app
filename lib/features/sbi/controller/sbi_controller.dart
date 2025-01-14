import 'package:flutter/material.dart';

import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';

class SbiProvider extends ChangeNotifier {
  SbiProvider() {
    loadingPayments();
  }

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _curIndex = 0;
  int get curIndex => _curIndex;

  // Payment items
  final List<Map<String, dynamic>> _sbiItems = [
    {
      "logo": AssetsPath.switchItem,
      "title": "SBI to IMPS Switch Over",
      'route': RoutesPath.impsSwitchOver,
      "cardColor": AppColor.card6,
      "cardTitle": AppColor.card6Title
    },
    {
      "logo": AssetsPath.request,
      "title": "SBI Manual Entry",
      'route': RoutesPath.sbiManuelEntry,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.close,
      "title": "SBI Portal Rejected Manual\nDebit Advice",
      'route': RoutesPath.rejectedManuelDebitAdvise,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
  ];

  // Report items
  final List<Map<String, dynamic>> _reportItem = [
    {
      "logo": AssetsPath.request,
      "title": "SBI Portal Report",
      'route': RoutesPath.sbiPortalReport,
      "cardColor": AppColor.card6,
      "cardTitle": AppColor.card6Title
    },
  ];

  List<Map<String, dynamic>> get sbiItems => _sbiItems;
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

  void setTabIndex(int index) {
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
        _curIndex == 0 ? sbiItems : reportItem;

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
    _filteredItems = List.from(sbiItems);
    notifyListeners();
  }

  void loadReportItem() {
    _filteredItems = List.from(reportItem);
    notifyListeners();
  }
}
