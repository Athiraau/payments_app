import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/pay_status_table_model.dart';
import '../repository/payment_status_repository.dart';

class PaymentStatusProvider extends ChangeNotifier {
  PaymentStatusProvider() {
    formatDateTime();
  }
  String curDocTitle = "Document ID";

  void updateTitle() {
    if (_selectedOption == '1') {
      curDocTitle = "Document ID";
      notifyListeners();
    } else if (_selectedOption == '2') {
      curDocTitle = "Customer ID";
      notifyListeners();
    } else if (_selectedOption == '3') {
      curDocTitle = "RR ID";
      notifyListeners();
    }
  }

  String _selectedOption = '1';
  String _branchName = '';

  String get branchName => _branchName;

  set branchName(String value) {
    _branchName = value;
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
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

  int _rowsPerPage = 10;

  int get rowsPerPage => _rowsPerPage;

  void updateRowsPage({required int data}) {
    _rowsPerPage = data;
  }

  bool hoverBtn = false;
  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  String get selectedOption => _selectedOption;

  void updateSelectedOption(String value) {
    _selectedOption = value;
    updateTitle();
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  //dummy data drop down
  List<Map<String, dynamic>> _moduleItem = [
    {"id": 1, "title": ""}
  ];

  final _api = PaymentStatusRepository();
  var payStatusTableModel = PayStatusTableModel();
  Future<void> fetchPayStatusData(
      {required BuildContext context, required String id}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response =
          await _api.fetchPayStatusData(ckBoxId: _selectedOption, id: id);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          payStatusTableModel = PayStatusTableModel.fromJson(response['data']);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed(RoutesName.paymentStatusReport);
          });
          notifyListeners();
        } else {
          CustomToast.showCustomErrorToast(message: "response is empty");
        }
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
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

  bool _showRRnum = false;

  bool get showRRnum => _showRRnum;

  set showRRnum(bool value) {
    _showRRnum = value;
  }

  Future<void> chkRRNumStatus() async {
    try {
      final response = await _api.chkRRNumStatus();
      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          final data = response['data']['response'][0]['CNT'].toString();
          if (data == '1') {
            showRRnum = true;
            notifyListeners();
          } else if (data == '0') {
            showRRnum = false;
            notifyListeners();
          }
        }
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
    } finally {}
  }
}
