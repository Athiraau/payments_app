import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';

class ImpsInquiryProvider extends ChangeNotifier {
  ImpsInquiryProvider() {
    formatDateTime();
  }
  String _branchName = '';

  String _selectedOption = 'Document ID';

  String get branchName => _branchName;

  String get selectedOption => _selectedOption;

  void updateSelectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
  }

  set branchName(String value) {
    _branchName = value;
  }
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  bool hoverBtn = false;
  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  String _formattedDate = '';
  String _formattedTime = '';
  Timer? _timer;

  String get formattedDate => _formattedDate;
  String get formattedTime => _formattedTime;

  set formattedDate(String value) {
    _formattedDate = value;
  }

  set formattedTime(String value) {
    _formattedTime = value;
  }

  Future<void> setCurBranchName() async {
    final _appCacheHelper = AppCacheHelper();
    final _appDecryptHelper = AppEncryptionHelper();
    final _encrptBranchName = await _appCacheHelper.getData("branchName");
    final _decrptBranchName = _appDecryptHelper.decryptData(
        data: _encrptBranchName.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    branchName = _decrptBranchName;
    notifyListeners();
  }

  void formatDateTime() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      final DateFormat dateFormat = DateFormat('MMM d, yyyy');
      final DateFormat timeFormat = DateFormat('hh:mm a');

      formattedDate = dateFormat.format(now);
      formattedTime = timeFormat.format(now);

      notifyListeners();
    });
  }

  String _validateId = '';

  set validateId(String value) {
    _validateId = value;
  }

  String get validateId => _validateId;

  void validateUserId({required String id, required String type}) {
    if (id.isEmpty) {
      validateId = '$type should not be empty';
      notifyListeners();
    } else {
      validateId = "";
    }
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
