import 'package:flutter/material.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/shared/constant/assets_path.dart';

class SliderProvider extends ChangeNotifier {
  ///List for slider items
  var items = [
    {"logo": AssetsPath.home, "title": "Home", 'route': RoutesPath.home},
    {
      "logo": AssetsPath.debitAdvice,
      "title": "Payments",
      'route': RoutesPath.payments
    },
    {
      "logo": AssetsPath.bankRecon,
      "title": "Bank Reconciliation",
      'route': RoutesPath.bankReconciliation
    },
    {"logo": AssetsPath.bank, "title": "SBI", 'route': RoutesPath.sbi},
    {
      "logo": AssetsPath.money,
      "title": "OTP Based Cash Withdrawal",
      'route': RoutesPath.otp_based
    },
    {"logo": AssetsPath.user, "title": "Others", 'route': RoutesPath.others},
  ];

  ///Set initially selected item has home
  String _selectedItem = 'Home';
  String get selectedItem => _selectedItem;

  set selectedItem(String value) {
    _selectedItem = value;
  }

  ///Expand drawer
  bool _isDrawerExpanded = true;

  bool get isDrawerExpanded => _isDrawerExpanded;

  void toggleDrawerExpansion() {
    _isDrawerExpanded = !_isDrawerExpanded;
    notifyListeners();
  }

  ///Hover over the drawer to check the selected item card
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  bool chkIsSelected({required String title}) {
    isSelected = selectedItem == title;
    return isSelected;
  }
}
