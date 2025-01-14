import 'package:flutter/material.dart';

class BreadCrumbsProvider with ChangeNotifier {
  List<String> _breadcrumbs = [];

  List<String> get breadcrumbs => _breadcrumbs;

  void addBreadcrumb(String breadcrumb) {
    _breadcrumbs.add(breadcrumb);
    notifyListeners();
  }

  void clearBreadcrumbs() {
    _breadcrumbs.clear();
    notifyListeners();
  }
}
