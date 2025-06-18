import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/branch_model.dart';
import '../model/change_req_data_model.dart';
import '../model/doc_id_model.dart';
import '../model/new_branch_model.dart';
import '../repository/change_debit_advise_repo.dart';
import 'package:flutter/material.dart';

class ChangeDebitAdviseProvider extends ChangeNotifier {
  TextEditingController branchController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  bool isLoading = false;
  final _api = ChangeDebitAdviseRepo();

  ///Page load
  Future<void> setData({required BuildContext context}) async {
    try {
      await fetchBranch(context: context);
      // if (!context.mounted) return;
      // await fetchDocument(context: context);
    } catch (e) {
      if (kDebugMode) {
        print("Error in setData: $e");
      }
      if (context.mounted) {
        CustomToast.showCustomErrorToast(message: "Failed to load data");
      }
    }
  }

  //Mouse hover
  bool hoverBtn = false;

  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  ///Api call
  ///branch dropdown
  List<BranchModel> branchList = [];
  int? selectedBranchId = -1;
  String? selectedBranch = '';
  void setSelectedBranch(
      {required String value, required BuildContext context}) {
    for (var e in branchList) {
      if (e.bRANCHNAME == value) {
        selectedBranchId = e.bRANCHID;
        selectedBranch = e.bRANCHNAME;
      }
    }
    docIdList = [];
    selectedDocId = '';
    selectedNewBranch = '';
    newBranchList = [];
    notifyListeners();
  }

  Future<void> fetchBranch({required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.fetchBranch();

      if (response != null && response['status'] == 200) {
        final items = (response['data']['response'] as List)
            .map((item) => BranchModel.fromJson(item))
            .toList();
        branchList = items;
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///document id dropdown
  List<DocIdModel> docIdList = [];
  String? selectedDocId = '';
  void setSelectedDocId({required String value}) {
    selectedDocId = value;
    notifyListeners();
  }

  Future<void> fetchDocument(
      {required BuildContext context, String? branchId}) async {
    try {
      final response = await _api.fetchDocument(branchId: branchId);

      if (response != null && response['status'] == 200) {
        final items = (response['data']['response'] as List)
            .map((item) => DocIdModel.fromJson(item))
            .toList();
        docIdList = items;
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///document id dropdown
  List<NewBranchModel> newBranchList = [];
  String? selectedNewBranch = '';
  void setSelectedNewBranch({required String value}) {
    selectedNewBranch = value;
    notifyListeners();
  }

  Future<void> fetchNewBranch(
      {required BuildContext context, String? branchId}) async {
    try {
      final response = await _api.fetchNewBranch(branchId: branchId);

      if (response != null && response['status'] == 200) {
        final items = (response['data']['response'] as List)
            .map((item) => NewBranchModel.fromJson(item))
            .toList();
        newBranchList = items;
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///Table data
  List<ChangeReqDataModel> tableDataList = [];
  int _rowsPerPage = 10;
  int get rowsPerPage => _rowsPerPage;
  void updateRowsPage({required int data}) {
    _rowsPerPage = data;
    notifyListeners();
  }

  Future<void> fetchTableData(
      {required BuildContext context, String? corId}) async {
    try {
      final response = await _api.fetchTableData(corId: corId);

      if (response != null && response['status'] == 200) {
        tableDataList = [];
        final items = (response['data']['response'] as List)
            .map((item) => ChangeReqDataModel.fromJson(item))
            .toList();
        tableDataList = items;
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///Update change debit advise branch
  Future<void> updateChangeDebitAdviseBranch(
      {required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.updateChangeDebitAdviseBranch(
          corId: selectedDocId,
          newBranchId: selectedNewBranch,
          oldBranchId: "$selectedBranchId");

      if (response != null && response['status'] == 200) {
        final splitResponse = response['data']['response'][0]['RES'].split('~');
        if (splitResponse[0].toString() == "0") {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomAlertDialog.showCustomAlertDialog(
              context: context,
              title: 'Success',
              message: splitResponse[1].toString(),
              cancelText: 'Ok',
              onCancelPressed: () {
                resetFields();
                context.pop();
              },
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomAlertDialog.showCustomAlertDialog(
              context: context,
              title: 'Failed',
              message: "failed to update",
              cancelText: 'Ok',
              onCancelPressed: () {
                context.pop();
              },
            );
          });
        }
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Reset all fields to their initial state
  void resetFields() {
    branchController.clear();
    docIdController.clear();
    selectedBranchId = -1;
    selectedBranch = '';
    docIdList = [];
    selectedDocId = '';
    newBranchList = [];
    selectedNewBranch = '';
    tableDataList = [];
    hoverBtn = false;
    isLoading = false;
    _rowsPerPage = 10;
    notifyListeners();
  }

  @override
  void dispose() {
    branchList = [];
    branchController.dispose();
    docIdController.dispose();
    super.dispose();
  }
}
