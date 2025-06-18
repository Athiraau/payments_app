import 'package:flutter/material.dart';

import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';

class OthersProvider extends ChangeNotifier {
  OthersProvider() {
    _initialize();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _othersItems = [];
  List<Map<String, dynamic>> get othersItems => _othersItems;

  List<Map<String, dynamic>> _filteredItems = [];
  List<Map<String, dynamic>> get filteredItems => _filteredItems;

  void _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    _othersItems = [
      {
        "logo": AssetsPath.email,
        "title": "Email Updations",
        'route': RoutesPath.email,
        "cardColor": AppColor.card1,
        "cardTitle": AppColor.card1Title
      },
      {
        "logo": AssetsPath.certificate,
        "title": "Interest Certificate",
        'route': RoutesPath.insertCertificate,
        "cardColor": AppColor.card2,
        "cardTitle": AppColor.card2Title
      },
    ];
    _filteredItems = List.from(_othersItems);
    _isLoading = false;
    notifyListeners();
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      _filteredItems = List.from(_othersItems);
    } else {
      _filteredItems = _othersItems
          .where((item) =>
              item["title"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  int _loadingIndex = -1;
  int get loadingIndex => _loadingIndex;

  set loadingIndex(int value) {
    _loadingIndex = value;
  }

  //transition
  int _curIndex = 0;

  int get curIndex => _curIndex;

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
