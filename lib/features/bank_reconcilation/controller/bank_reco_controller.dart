import 'package:flutter/material.dart';

import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';

class BankRecoProvider extends ChangeNotifier {
  BankRecoProvider() {
    loadingPayments();
  }

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _curIndex = 0;
  int get curIndex => _curIndex;

  // Payment items
  final List<Map<String, dynamic>> _bankRecoItems = [
    {
      "logo": AssetsPath.updations,
      "title": "BRS Updation",
      'route': RoutesPath.brsUpdation,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.missing,
      "title": "BRS Mismatch Updation",
      'route': RoutesPath.brsMismatchUpdate,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.close,
      "title": "BRS Wrong Updation\nReversal",
      'route': RoutesPath.brsWrongUpdationReversal,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.request,
      "title": "Yes Bank Statement\nFile Upload",
      'route': RoutesPath.yesBankStatementFileUpload,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
    {
      "logo": AssetsPath.upload,
      "title": "Yes Bank NEFT\nResponse File Upload",
      'route': RoutesPath.yesBankNeftResponseFileUpload,
      "cardColor": AppColor.card5,
      "cardTitle": AppColor.card5Title
    },
    {
      "logo": AssetsPath.charges,
      "title": "Yes Bank File Upload -\nFee and Charges",
      'route': RoutesPath.yesBankFileUploadFeeAndCharges,
      "cardColor": AppColor.card6,
      "cardTitle": AppColor.card6Title
    },
  ];

  // Report items
  final List<Map<String, dynamic>> _reportItem = [
    {
      "logo": AssetsPath.request,
      "title": "Bank Unreconciled Report",
      'route': RoutesPath.bankUnreconciledReport,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.report1,
      "title": "Bank Reconciled Report",
      'route': RoutesPath.bankReconciledReport,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.report2,
      "title": "Bank Unreconciled\nConsolidated Report",
      'route': RoutesPath.bankReconciledConsolidatedReport,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.close,
      "title": "Bank Statement\nMissing Report",
      'route': RoutesPath.bankStatementMissingReport,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
  ];
  final List<Map<String, dynamic>> _newReportItem = [
    {
      "logo": AssetsPath.report2,
      "title": "Reconciled Report -\nConsolidated",
      'route': RoutesPath.reconciledReportConsolidated,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.report1,
      "title": "Unreconciled Report -\nConsolidated",
      'route': RoutesPath.unreconciledReportConsolidated,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.request,
      "title": "Bank Statement",
      'route': RoutesPath.bankStatement,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
  ];

  final List<Map<String, dynamic>> _hoReportItem = [
    {
      "logo": AssetsPath.request,
      "title": "Unreconciled Report -\nConsolidated",
      'route': RoutesPath.hounreconciledReportConsolidated,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    }
  ];

  List<Map<String, dynamic>> get bankRecoItems => _bankRecoItems;
  List<Map<String, dynamic>> get reportItem => _reportItem;
  List<Map<String, dynamic>> get newReportItem => _newReportItem;
  List<Map<String, dynamic>> get hoReportItem => _hoReportItem;
  List<Map<String, dynamic>> _filteredItems = [];
  List<Map<String, dynamic>> get filteredItems => _filteredItems;

  Future<void> loadingPayments() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _isLoading = false;
      loadBankRecoItem();
      notifyListeners();
    });
  }

  void setTabIndex(int index) {
    _curIndex = index;
    print("curr$_curIndex");
    if (_curIndex == 0) {
      loadBankRecoItem();
    } else if (_curIndex == 1) {
      loadReportItem();
    } else if (_curIndex == 2) {
      loadNewReportItem();
    } else {
      loadHOReportItem();
    }
    notifyListeners();
  }

  void searchItems(String query) {
    List<Map<String, dynamic>> sourceList =
        _curIndex == 0 ? bankRecoItems : reportItem;

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

  void loadBankRecoItem() {
    _filteredItems = List.from(bankRecoItems);
    notifyListeners();
  }

  void loadReportItem() {
    _filteredItems = List.from(reportItem);
    notifyListeners();
  }

  void loadNewReportItem() {
    _filteredItems = List.from(newReportItem);
    notifyListeners();
  }

  void loadHOReportItem() {
    _filteredItems = List.from(hoReportItem);
    notifyListeners();
  }


  int _loadingIndex=-1;
  int get loadingIndex => _loadingIndex;

  set loadingIndex(int value) {
    _loadingIndex = value;
  }


  //transition

  set curIndex(int value) {
    _curIndex = value;
  }

  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
  }

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
}
