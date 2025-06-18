import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    _monitorConnection();
  }

  void _monitorConnection() {
    InternetConnection().onStatusChange.listen((status) {
      _isConnected = status == InternetStatus.connected;
      notifyListeners();
    });
  }
}