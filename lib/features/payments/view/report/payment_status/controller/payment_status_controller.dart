import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payment_app/features/payments/view/report/payment_status/model/seq_id_3.dart';
import 'package:flutter_payment_app/features/payments/view/report/payment_status/model/seq_id_4.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/cor_id_model1.dart';
import '../model/cor_id_model2.dart';
import '../model/cor_id_model3.dart';
import '../model/cust_id_model.dart';
import '../model/doc_id_1.dart';
import '../model/doc_id_2.dart';
import '../model/doc_id_model1.dart';
import '../model/doc_id_model2.dart';
import '../model/pay_status_table_model.dart';
import '../model/seq_data_model1.dart';
import '../model/seq_data_model2.dart';
import '../model/seq_data_model3.dart';
import '../model/seq_data_model4.dart';
import '../model/seq_data_model5.dart';
import '../model/seq_id_1.dart';
import '../model/seq_id_2.dart';
import '../model/seq_id_5.dart';
import '../repository/payment_status_repository.dart';
import 'package:universal_html/html.dart' as html;

import '../view/widget/doc_id_widget.dart';
import '../view/widget/seq_number_widgets.dart';

class PaymentStatusProvider extends ChangeNotifier {
  PaymentStatusProvider() {
    formatDateTime();
  }
  final FocusNode focusNode = FocusNode();

  ///Function for getting date and time
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

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      final DateFormat dateFormat = DateFormat('MMM d, yyyy');
      final DateFormat timeFormat = DateFormat('hh:mm a');

      formattedDate = dateFormat.format(now);
      formattedTime = timeFormat.format(now);

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  ///Radio button selection
  String curDocTitle = "Document ID";
  String _selectedOption = '1';
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

  ///Check visibility of RRNum
  bool _showRRnum = false;

  bool get showRRnum => _showRRnum;

  set showRRnum(bool value) {
    _showRRnum = value;
  }

  ///Api for check RRNum status
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
    }
  }

  ///Function for validation
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
      notifyListeners();
    }
  }

  ///Fetching branch name from shared preference
  String _branchName = '';

  String get branchName => _branchName;

  set branchName(String value) {
    _branchName = value;
  }

  Future<void> setCurBranchName() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptBranchName = await appCacheHelper.getData("branchName");
    final decrptBranchName = appDecryptHelper.decryptData(
        data: encrptBranchName.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    branchName = decrptBranchName;
    notifyListeners();
  }

  ///Rows per page in data table

  ///transition in Grid or List in UI

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

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  ///Api calls
  ///Table data
  List<PaymentStatusTable> tableDataList = [];
  final _api = PaymentStatusRepository();
  int _rowsPerPage = 10;
  int get rowsPerPage => _rowsPerPage;
  void updateRowsPage({required int data}) {
    _rowsPerPage = data;
    notifyListeners();
  }

  Future<void> fetchPayStatusData(
      {required BuildContext context, required String id}) async {
    try {
      final response =
          await _api.fetchPayStatusData(ckBoxId: _selectedOption, id: id);

      if (response != null && response['status'] == 200) {
        tableDataList = [];
        final items = (response['data']['response'] as List)
            .map((item) => PaymentStatusTable.fromJson(item))
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

  ///Customer Id
  Future<void> fetchCusIdImg(
      {required String custId, required BuildContext context}) async {
    try {
      final response = await _api.fetchCusIdImg(custId: custId);

      if (response == null || response['status'] != 200) {
        CustomToast.showCustomErrorToast(message: "Failed to fetch data");
        notifyListeners();
        return;
      }

      if (!context.mounted) return;

      final responseData = response['data']?['response'];

      // Check if responseData is null, not a list, or empty
      if (responseData == null ||
          responseData is! List ||
          responseData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No data found"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final firstItem = responseData[0];
      final idProof = firstItem['ID_PROOF'];

      if (idProof == null || idProof.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No ID proof available"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              child: SingleChildScrollView(
                child: Column(
                  children: [Image.memory(base64Decode(idProof))],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KeyboardListener(
                    focusNode: focusNode,
                    autofocus: true,
                    onKeyEvent: (event) {
                      if (event is KeyDownEvent &&
                          event.logicalKey == LogicalKeyboardKey.enter) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.drawerImgTileColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Ok',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  ///Sequance Number
  List<Seq1> seq1DataList = [];
  List<Seq2> seq2DataList = [];
  List<Seq3> seq3DataList = [];
  List<Seq4> seq4DataList = [];
  List<Seq5> seq5DataList = [];
  int _rowsPerPageSeq1 = 10;

  int get rowsPerPageSeq1 => _rowsPerPageSeq1;

  void updateRowsPageSeq1({required int data}) {
    _rowsPerPageSeq1 = data;
    notifyListeners();
  }

  int _rowsPerPageSeq2 = 10;

  int get rowsPerPageSeq2 => _rowsPerPageSeq2;

  void updateRowsPageSeq2({required int data}) {
    _rowsPerPageSeq2 = data;
    notifyListeners();
  }

  int _rowsPerPageSeq3 = 10;

  int get rowsPerPageSeq3 => _rowsPerPageSeq3;

  void updateRowsPageSeq3({required int data}) {
    _rowsPerPageSeq3 = data;
    notifyListeners();
  }

  int _rowsPerPageSeq4 = 10;

  int get rowsPerPageSeq4 => _rowsPerPageSeq4;

  void updateRowsPageSeq4({required int data}) {
    _rowsPerPageSeq4 = data;
    notifyListeners();
  }

  int _rowsPerPageSeq5 = 10;

  int get rowsPerPageSeq5 => _rowsPerPageSeq5;

  void updateRowsPageSeq5({required int data}) {
    _rowsPerPageSeq2 = data;
    notifyListeners();
  }

  Future<void> fetchSeqNumData(
      {required BuildContext context, required String seqNum}) async {
    try {
      final response = await _api.fetchSeqNumData(seqNum: seqNum);

      if (response != null && response['status'] == 200) {
        seq1DataList = [];
        seq2DataList = [];
        seq3DataList = [];
        seq4DataList = [];
        seq5DataList = [];
        final items1 = (response['data']['response'][0]["Seq1"] as List)
            .map((item) => Seq1.fromJson(item))
            .toList();

        seq1DataList = items1;
        notifyListeners();
        final items2 = (response['data']['response'][0]["Seq2"] as List)
            .map((item) => Seq2.fromJson(item))
            .toList();

        seq2DataList = items2;
        notifyListeners();

        final items3 = (response['data']['response'][0]["Seq3"] as List)
            .map((item) => Seq3.fromJson(item))
            .toList();

        seq3DataList = items3;
        notifyListeners();

        final items4 = (response['data']['response'][0]["Seq4"] as List)
            .map((item) => Seq4.fromJson(item))
            .toList();

        seq4DataList = items4;
        notifyListeners();

        final items5 = (response['data']['response'][0]["Seq5"] as List)
            .map((item) => Seq5.fromJson(item))
            .toList();

        seq5DataList = items5;
        notifyListeners();

        if (context.mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.70,
                      maxHeight: MediaQuery.of(context).size.height *
                          0.6, // More flexible height
                    ),
                    child: Consumer<PaymentStatusProvider>(
                      builder: (context, provider, child) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SeqNumberWidgets(
                                width: MediaQuery.of(context).size.width * 0.70,
                                height: 400,
                                provider: provider,
                                seqNum1: seq1DataList,
                                seqNum2: seq2DataList,
                                seqNum3: seq3DataList,
                                seqNum4: seq4DataList,
                                seqNum5: seq5DataList,
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyboardListener(
                          focusNode: focusNode,
                          autofocus: true,
                          onKeyEvent: (event) {
                            if (event is KeyDownEvent &&
                                event.logicalKey == LogicalKeyboardKey.enter) {
                              seq1DataList = [];
                              seq2DataList = [];
                              seq3DataList = [];
                              seq4DataList = [];
                              seq5DataList = [];
                              Navigator.of(context).pop();
                            }
                          },
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.drawerImgTileColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              seq1DataList = [];
                              seq2DataList = [];
                              seq3DataList = [];
                              seq4DataList = [];
                              seq5DataList = [];
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Ok',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }
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

  ///Doc Id
  List<DocId1> docId1DataList = [];
  List<DocId2> docId2DataList = [];
  Future<void> fetchDocIdData(
      {required BuildContext context, required String docId}) async {
    try {
      final response = await _api.fetchDocIdData(docId: docId);

      if (response != null && response['status'] == 200) {
        docId1DataList = [];
        docId2DataList = [];
        final items1 = (response['data']['response'][0]["docId1"] as List)
            .map((item) => DocId1.fromJson(item))
            .toList();

        docId1DataList = items1;
        notifyListeners();
        final items2 = (response['data']['response'][0]["docId2"] as List)
            .map((item) => DocId2.fromJson(item))
            .toList();

        docId2DataList = items2;
        notifyListeners();

        if (context.mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.70,
                      maxHeight: MediaQuery.of(context).size.height *
                          0.6, // More flexible height
                    ),
                    child: Consumer<PaymentStatusProvider>(
                      builder: (context, provider, child) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              DocIdWidget(
                                width: MediaQuery.of(context).size.width * 0.70,
                                height: 400,
                                provider: provider,
                                docId1: docId1DataList,
                                docId2: docId2DataList,
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyboardListener(
                          focusNode: focusNode,
                          autofocus: true,
                          onKeyEvent: (event) {
                            if (event is KeyDownEvent &&
                                event.logicalKey == LogicalKeyboardKey.enter) {
                              docId1DataList = [];
                              docId2DataList = [];
                              Navigator.of(context).pop();
                            }
                          },
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.drawerImgTileColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              docId1DataList = [];
                              docId2DataList = [];
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Ok',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }
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

  ///Cor Id
  List<CorIdResponse1> corId1DataList = [];
  List<DocId2> corId2DataList = [];
  List<DocId2> corId3DataList = [];
  Future<void> fetchCorIdData(
      {required BuildContext context,
      required String corID,
      required String flag}) async {
    try {
      final response = await _api.fetchCorIdData(corId: corID, flag: flag);

      if (response != null && response['status'] == 200) {
        if (flag == "GETPAYMENTREPORT3") {
          if (response['data']['response'][0]["'0'"].toString() == "0") {
            corId1DataList = [];
            notifyListeners();
          } else {
            final items = (response['data']['response']["result"] as List)
                .map((item) => CorIdResponse1.fromJson(item))
                .toList();

            corId1DataList = items;
            notifyListeners();
          }
        } else if (flag == "GETPAYMENTREPORT4") {
        } else if (flag == "GETPAYMENTREPORT5") {}
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

  ///Function to export data table data to excel
  bool loadExcelReport = false;

  //Api for fetching docId -- table 1
  var docIdModel1 = DocIdModel1();
  bool isLoadingDocId1 = false;
  Future<void> fetchDocIdData1(
      {required BuildContext context, required String docId}) async {
    try {
      isLoadingDocId1 = true;
      notifyListeners();
      final response = await _api.fetchDocIdData1(docId: docId);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          docIdModel1 = DocIdModel1.fromJson(response['data']);
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
      isLoadingDocId1 = false;
      notifyListeners();
    }
  }

  //Api for fetching docId -- table 2
  var docIdModel2 = DocIdModel2();
  bool isLoadingDocId2 = false;
  Future<void> fetchDocIdData2(
      {required BuildContext context, required String docId}) async {
    try {
      isLoadingDocId2 = true;
      notifyListeners();
      final response = await _api.fetchDocIdData2(docId: docId);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          docIdModel2 = DocIdModel2.fromJson(response['data']);
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
      isLoadingDocId2 = false;
      notifyListeners();
    }
  }

  //Api for fetching corId -- table 1
  // var corIdDataModel1 = CorIDdataModel1();
  // var corDataList1 = <CorIDdataModel1>[];
  // bool isLoadingCorId1 = false;
  // Future<void> fetchCorIdData1({
  //   required BuildContext context,
  //   required String corId,
  // }) async {
  //   try {
  //     isLoadingCorId1 = true;
  //     notifyListeners();
  //
  //     final response = await _api.fetchCorIdData1(corId: corId);
  //
  //     if (response != null && response['status'] == 200) {
  //       if (response['data']['response'] != null &&
  //           response['data']['response'].isNotEmpty) {
  //         if (response['data']['response'][0]["'0'"].toString() == "0") {
  //           corDataList1 = [];
  //           notifyListeners();
  //         } else {
  //           corIdDataModel1 = CorIDdataModel1.fromJson(response['data']);
  //           corDataList1.add(corIdDataModel1);
  //           notifyListeners();
  //         }
  //       } else {
  //         CustomToast.showCustomErrorToast(message: "Response is empty");
  //       }
  //     } else {
  //       CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error: $e");
  //     }
  //     CustomToast.showCustomErrorToast(message: "An error occurred: $e");
  //   } finally {
  //     isLoadingCorId1 = false;
  //     notifyListeners();
  //   }
  // }

  // //Api for fetching corId -- table 2
  // var corIDdataModel2 = CorIDdataModel2();
  // var corDataList2 = <CorIDdataModel2>[];
  // bool isLoadingCorId2 = false;
  // Future<void> fetchCorIdData2({
  //   required BuildContext context,
  //   required String corId,
  // }) async {
  //   try {
  //     isLoadingCorId2 = true;
  //     notifyListeners();
  //
  //     final response = await _api.fetchCorIdData2(corId: corId);
  //
  //     if (response != null && response['status'] == 200) {
  //       if (response['data']['response'] != null &&
  //           response['data']['response'].isNotEmpty) {
  //         if (response['data']['response'][0]["'0'"].toString() == "0") {
  //           corDataList2 = [];
  //           notifyListeners();
  //         } else {
  //           corIDdataModel2 = CorIDdataModel2.fromJson(response['data']);
  //           corDataList2.add(corIDdataModel2);
  //           notifyListeners();
  //         }
  //       } else {
  //         CustomToast.showCustomErrorToast(message: "Response is empty");
  //       }
  //     } else {
  //       CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error: $e");
  //     }
  //     CustomToast.showCustomErrorToast(message: "An error occurred: $e");
  //   } finally {
  //     isLoadingCorId2 = false;
  //     notifyListeners();
  //   }
  // }

  // //Api for fetching corId -- table 3
  // var corIDdataModel3 = CorIDdataModel3();
  // bool isLoadingCorId3 = false;
  // Future<void> fetchCorIdData3(
  //     {required BuildContext context, required String corId}) async {
  //   try {
  //     isLoadingCorId3 = true;
  //     notifyListeners();
  //     final response = await _api.fetchCorIdData3(corId: corId);
  //
  //     if (response != null && response['status'] == 200) {
  //       if (response['data']['response'] != null) {
  //         corIDdataModel3 = CorIDdataModel3.fromJson(response['data']);
  //         notifyListeners();
  //       } else {
  //         CustomToast.showCustomErrorToast(message: "response is empty");
  //       }
  //     } else {
  //       CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error $e");
  //     }
  //   } finally {
  //     isLoadingCorId3 = false;
  //     notifyListeners();
  //   }
  // }

  //Api for fetching Sequence id -- table 1
  var seqDataModel1 = SeqDataModel1();
  bool isLoadingSeqId1 = false;
  Future<void> fetchSeqData1(
      {required BuildContext context, required String seqNo}) async {
    try {
      isLoadingSeqId1 = true;
      notifyListeners();
      final response = await _api.fetchSeqData1(seqNo: seqNo);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          seqDataModel1 = SeqDataModel1.fromJson(response['data']);
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
      isLoadingSeqId1 = false;
      notifyListeners();
    }
  }

  //Api for fetching Sequence id -- table 2
  var seqDataModel2 = SeqDataModel2();
  bool isLoadingSeqId2 = false;
  Future<void> fetchSeqData2(
      {required BuildContext context, required String seqNo}) async {
    try {
      isLoadingSeqId2 = true;
      notifyListeners();
      final response = await _api.fetchSeqData2(seqNo: seqNo);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          seqDataModel2 = SeqDataModel2.fromJson(response['data']);
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
      isLoadingSeqId2 = false;
      notifyListeners();
    }
  }

  //Api for fetching Sequence id -- table 3
  var seqDataModel3 = SeqDataModel3();
  bool isLoadingSeqId3 = false;
  Future<void> fetchSeqData3(
      {required BuildContext context, required String seqNo}) async {
    try {
      isLoadingSeqId3 = true;
      notifyListeners();
      final response = await _api.fetchSeqData3(seqNo: seqNo);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          seqDataModel3 = SeqDataModel3.fromJson(response['data']);
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
      isLoadingSeqId3 = false;
      notifyListeners();
    }
  }

  //Api for fetching Sequence id -- table 4
  var seqDataModel4 = SeqDataModel4();
  bool isLoadingSeqId4 = false;
  Future<void> fetchSeqData4(
      {required BuildContext context, required String seqNo}) async {
    try {
      isLoadingSeqId4 = true;
      notifyListeners();
      final response = await _api.fetchSeqData1(seqNo: seqNo);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          seqDataModel4 = SeqDataModel4.fromJson(response['data']);
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
      isLoadingSeqId4 = false;
      notifyListeners();
    }
  }

  //Api for fetching Sequence id -- table 5
  var seqDataModel5 = SeqDataModel5();
  bool isLoadingSeqId5 = false;
  Future<void> fetchSeqData5(
      {required BuildContext context, required String seqNo}) async {
    try {
      isLoadingSeqId5 = true;
      notifyListeners();
      final response = await _api.fetchSeqData1(seqNo: seqNo);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          seqDataModel5 = SeqDataModel5.fromJson(response['data']);
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
      isLoadingSeqId5 = false;
      notifyListeners();
    }
  }

  ///Function to export doc table  1 data to excel
  Future<void> exportToExcelDocId1(BuildContext context) async {
    try {
      loadExcelReport = true;
      notifyListeners();

      if (docIdModel1.docId1response!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: AppColor.drawerColor,
              content: Text(
                'No data to export',
                style: TextStyle(fontFamily: 'poppinsRegular'),
              )),
        );
        return;
      }

      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];
      List<String> headers = [
        'Module',
        'Branch',
        'BranchId',
        'DocId',
        'CustomerId',
        'Amount',
        'TraDate',
        'SendDate',
        'SendTransId',
        'CorporateId',
        'BatchNumber',
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      for (int i = 0; i < docIdModel1.docId1response!.length; i++) {
        ResponseDocId1 item = docIdModel1.docId1response![i];
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.mODDESCR ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.bRANCHNAME ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue("${item.bRANCHID ?? ''}");
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue(item.dOCID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.cUSTID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue('${item.aMOUNT ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = TextCellValue(item.vALUEDATE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = TextCellValue(item.sENDDATE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
            .value = TextCellValue(item.sENDTRANSID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
            .value = TextCellValue(item.cORPORATEID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
            .value = TextCellValue(item.bATCHNO ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'Transaction Details$formattedDate.xlsx';

      if (kIsWeb) {
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: AppColor.drawerColor,
                  content: Text(
                    'Excel file downloaded: $fileName',
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'poppinsRegular'),
                  )),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      loadExcelReport = false;
      notifyListeners();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    } finally {
      loadExcelReport = false;
      notifyListeners();
    }
  }

  ///Function to export doc table  2 data to excel

  Future<void> exportToExcelDocId2(BuildContext context) async {
    try {
      loadExcelReport = true;
      notifyListeners();

      if (docIdModel2.docId2response!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: AppColor.drawerColor,
              content: Text(
                'No data to export',
                style: TextStyle(fontFamily: 'poppinsRegular'),
              )),
        );
        return;
      }

      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];
      List<String> headers = [
        'Customer Name',
        'Account Number',
        'IFSC Code',
        'Bank',
        'Status',
        'CustRefId',
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      for (int i = 0; i < docIdModel2.docId2response!.length; i++) {
        ResponseDocId2 item = docIdModel2.docId2response![i];
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.cUSTNAME ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.bENEFICIARYACCOUNT ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.iFSCCODE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue(item.bANKNAME ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.sTATUS ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue(item.cUSTID ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'Neft Customer Details$formattedDate.xlsx';

      if (kIsWeb) {
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: AppColor.drawerColor,
                  content: Text(
                    'Excel file downloaded: $fileName',
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'poppinsRegular'),
                  )),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      loadExcelReport = false;
      notifyListeners();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    } finally {
      loadExcelReport = false;
      notifyListeners();
    }
  }

  ///Function to export corId table  1 data to excel
  // Future<void> exportToExcelCorId1(BuildContext context) async {
  //   try {
  //     loadExcelReport = true;
  //     notifyListeners();
  //
  //     if (corIdDataModel1.response!.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             backgroundColor: AppColor.drawerColor,
  //             content: Text(
  //               'No data to export',
  //               style: TextStyle(fontFamily: 'poppinsRegular'),
  //             )),
  //       );
  //       return;
  //     }
  //
  //     var excel = Excel.createExcel();
  //     Sheet sheetObject = excel['Sheet1'];
  //     List<String> headers = ['ImpsTransNo', 'TraDate', 'Bank'];
  //
  //     // Add headers
  //     for (int i = 0; i < headers.length; i++) {
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
  //           .value = TextCellValue(headers[i]);
  //     }
  //
  //     for (int i = 0; i < corIdDataModel1.response!.length; i++) {
  //       CorIdResponse1 item = corIdDataModel1.response![i];
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
  //           .value = TextCellValue(item.cORPORATEID ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
  //           .value = TextCellValue(item.tRADT ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
  //           .value = TextCellValue(item.bANK ?? '');
  //     }
  //     String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
  //     String fileName = 'IMPS Sending Details$formattedDate.xlsx';
  //
  //     if (kIsWeb) {
  //       final bytes = await excel.encode(); // Get the bytes of the Excel file
  //       if (bytes != null) {
  //         final blob = html.Blob([bytes]);
  //         final url = html.Url.createObjectUrlFromBlob(blob);
  //         final anchor = html.AnchorElement(href: url)
  //           ..setAttribute("download", fileName) // Use filename variable
  //           ..click();
  //         html.Url.revokeObjectUrl(url);
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //                 backgroundColor: AppColor.drawerColor,
  //                 content: Text(
  //                   'Excel file downloaded: $fileName',
  //                   style: const TextStyle(
  //                       color: Colors.white, fontFamily: 'poppinsRegular'),
  //                 )),
  //           );
  //         });
  //       } else {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Failed to generate Excel file')),
  //           );
  //         });
  //       }
  //     } else {
  //       var status = await Permission.storage.request();
  //       if (status.isGranted) {
  //         Directory? downloadsDirectory = await getExternalStorageDirectory();
  //         String filePath = '${downloadsDirectory!.path}/Download/$fileName';
  //         File file = File(filePath);
  //         await file.create(recursive: true);
  //         final bytes = excel.encode();
  //         if (bytes != null) {
  //           await file.writeAsBytes(bytes);
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Excel file saved to: $filePath')),
  //             );
  //           });
  //         } else {
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Failed to generate Excel file')),
  //             );
  //           });
  //         }
  //       } else {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Storage permission denied')),
  //           );
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     loadExcelReport = false;
  //     notifyListeners();
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error exporting to Excel: $e')),
  //       );
  //     });
  //   } finally {
  //     loadExcelReport = false;
  //     notifyListeners();
  //   }
  // }

  ///Function to export corId table  2 data to excel
  // Future<void> exportToExcelCorId2(BuildContext context) async {
  //   try {
  //     loadExcelReport = true;
  //     notifyListeners();
  //
  //     if (corIDdataModel2.response!.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             backgroundColor: AppColor.drawerColor,
  //             content: Text(
  //               'No data to export',
  //               style: TextStyle(fontFamily: 'poppinsRegular'),
  //             )),
  //       );
  //       return;
  //     }
  //
  //     var excel = Excel.createExcel();
  //     Sheet sheetObject = excel['Sheet1'];
  //     List<String> headers = [
  //       'Corporate ID',
  //       'TraDate',
  //       'Response Code',
  //       'RESPONSE',
  //       'BankRRN',
  //       'BankRefNum',
  //       'TransId',
  //       'Bank'
  //     ];
  //
  //     // Add headers
  //     for (int i = 0; i < headers.length; i++) {
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
  //           .value = TextCellValue(headers[i]);
  //     }
  //
  //     for (int i = 0; i < corIDdataModel2.response!.length; i++) {
  //       CorIdResponse2 item = corIDdataModel2.response![i];
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
  //           .value = TextCellValue(item.tRANREFNO ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
  //           .value = TextCellValue(item.tRADT ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
  //           .value = TextCellValue(item.aCTCODE ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
  //           .value = TextCellValue(item.rESPONSE ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
  //           .value = TextCellValue(item.bANKRRN ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
  //           .value = TextCellValue(item.bANKREFNUM ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
  //           .value = TextCellValue("${item.tRANSID ?? ''}");
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
  //           .value = TextCellValue(item.bANK ?? '');
  //     }
  //     String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
  //     String fileName = 'IMPS Sending Response$formattedDate.xlsx';
  //
  //     if (kIsWeb) {
  //       final bytes = await excel.encode(); // Get the bytes of the Excel file
  //       if (bytes != null) {
  //         final blob = html.Blob([bytes]);
  //         final url = html.Url.createObjectUrlFromBlob(blob);
  //         final anchor = html.AnchorElement(href: url)
  //           ..setAttribute("download", fileName) // Use filename variable
  //           ..click();
  //         html.Url.revokeObjectUrl(url);
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //                 backgroundColor: AppColor.drawerColor,
  //                 content: Text(
  //                   'Excel file downloaded: $fileName',
  //                   style: const TextStyle(
  //                       color: Colors.white, fontFamily: 'poppinsRegular'),
  //                 )),
  //           );
  //         });
  //       } else {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Failed to generate Excel file')),
  //           );
  //         });
  //       }
  //     } else {
  //       var status = await Permission.storage.request();
  //       if (status.isGranted) {
  //         Directory? downloadsDirectory = await getExternalStorageDirectory();
  //         String filePath = '${downloadsDirectory!.path}/Download/$fileName';
  //         File file = File(filePath);
  //         await file.create(recursive: true);
  //         final bytes = excel.encode();
  //         if (bytes != null) {
  //           await file.writeAsBytes(bytes);
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Excel file saved to: $filePath')),
  //             );
  //           });
  //         } else {
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Failed to generate Excel file')),
  //             );
  //           });
  //         }
  //       } else {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Storage permission denied')),
  //           );
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     loadExcelReport = false;
  //     notifyListeners();
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error exporting to Excel: $e')),
  //       );
  //     });
  //   } finally {
  //     loadExcelReport = false;
  //     notifyListeners();
  //   }
  // }

  ///Function to export corId table 3 data to excel
  // Future<void> exportToExcelCorId3(BuildContext context) async {
  //   try {
  //     loadExcelReport = true;
  //     notifyListeners();
  //
  //     if (corIDdataModel3.response!.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             backgroundColor: AppColor.drawerColor,
  //             content: Text(
  //               'No data to export',
  //               style: TextStyle(fontFamily: 'poppinsRegular'),
  //             )),
  //       );
  //       return;
  //     }
  //
  //     var excel = Excel.createExcel();
  //     Sheet sheetObject = excel['Sheet1'];
  //
  //     List<String> headers = [
  //       'UNIQUE_REF_NO',
  //       'PAY_DATE',
  //       'TRA_UTR_NO',
  //       'CHQ_NO',
  //       'STATUS',
  //       'STATUS_DESC',
  //       'BANK_REF_NO',
  //       'AMOUNT',
  //       'BENEFICIARY_ACC_NO',
  //       'TRA_DATE',
  //       'TRANSID',
  //       'BATCH_NO',
  //     ];
  //
  //     // Add headers
  //     for (int i = 0; i < headers.length; i++) {
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
  //           .value = TextCellValue(headers[i]);
  //     }
  //
  //     for (int i = 0; i < corIDdataModel3.response!.length; i++) {
  //       CorIdResponse3 item = corIDdataModel3.response![i];
  //
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
  //           .value = TextCellValue(item.uNIQUEREFNO ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
  //           .value = TextCellValue(item.pAYDATE ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
  //           .value = TextCellValue(item.tRAUTRNO ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
  //           .value = TextCellValue(item.cHQNO ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
  //           .value = TextCellValue(item.sTATUS ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
  //           .value = TextCellValue(item.sTATUSDESC ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
  //           .value = TextCellValue(item.bANKREFNO ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
  //           .value = TextCellValue(item.aMOUNT ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
  //           .value = TextCellValue(item.bENEFICIARYACCNO ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
  //           .value = TextCellValue(item.tRADATE ?? '');
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
  //           .value = TextCellValue("${item.tRANSID ?? ''}");
  //       sheetObject
  //           .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
  //           .value = TextCellValue(item.bATCHNO ?? '');
  //     }
  //     String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
  //     String fileName = 'report$formattedDate.xlsx';
  //
  //     if (kIsWeb) {
  //       final bytes = await excel.encode(); // Get the bytes of the Excel file
  //       if (bytes != null) {
  //         final blob = html.Blob([bytes]);
  //         final url = html.Url.createObjectUrlFromBlob(blob);
  //         final anchor = html.AnchorElement(href: url)
  //           ..setAttribute("download", fileName) // Use filename variable
  //           ..click();
  //         html.Url.revokeObjectUrl(url);
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //                 backgroundColor: AppColor.drawerColor,
  //                 content: Text(
  //                   'Excel file downloaded: $fileName',
  //                   style: const TextStyle(
  //                       color: Colors.white, fontFamily: 'poppinsRegular'),
  //                 )),
  //           );
  //         });
  //       } else {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Failed to generate Excel file')),
  //           );
  //         });
  //       }
  //     } else {
  //       var status = await Permission.storage.request();
  //       if (status.isGranted) {
  //         Directory? downloadsDirectory = await getExternalStorageDirectory();
  //         String filePath = '${downloadsDirectory!.path}/Download/$fileName';
  //         File file = File(filePath);
  //         await file.create(recursive: true);
  //         final bytes = excel.encode();
  //         if (bytes != null) {
  //           await file.writeAsBytes(bytes);
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Excel file saved to: $filePath')),
  //             );
  //           });
  //         } else {
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Failed to generate Excel file')),
  //             );
  //           });
  //         }
  //       } else {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Storage permission denied')),
  //           );
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     loadExcelReport = false;
  //     notifyListeners();
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error exporting to Excel: $e')),
  //       );
  //     });
  //   } finally {
  //     loadExcelReport = false;
  //     notifyListeners();
  //   }
  // }

  ///Function to export SeqId table  1 data to excel
  Future<void> exportToExcelSeqId1(BuildContext context) async {
    try {
      loadExcelReport = true;
      notifyListeners();

      if (seqDataModel1.response!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: AppColor.drawerColor,
              content: Text(
                'No data to export',
                style: TextStyle(fontFamily: 'poppinsRegular'),
              )),
        );
        return;
      }

      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        'ImpsTransNo',
        'Bank',
        'TraDate',
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      for (int i = 0; i < seqDataModel1.response!.length; i++) {
        SeqData1Response item = seqDataModel1.response![i];
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.cORPORATEID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.bANK ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.tRADT ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'IMPS Sending details$formattedDate.xlsx';

      if (kIsWeb) {
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: AppColor.drawerColor,
                  content: Text(
                    'Excel file downloaded: $fileName',
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'poppinsRegular'),
                  )),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      loadExcelReport = false;
      notifyListeners();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    } finally {
      loadExcelReport = false;
      notifyListeners();
    }
  }

  ///Function to export SeqId table 2 data to excel
  Future<void> exportToExcelSeqId2(BuildContext context) async {
    try {
      loadExcelReport = true;
      notifyListeners();

      if (seqDataModel2.response!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: AppColor.drawerColor,
              content: Text(
                'No data to export',
                style: TextStyle(fontFamily: 'poppinsRegular'),
              )),
        );
        return;
      }

      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];
      List<String> headers = [
        'CorporateId',
        'TraDate',
        'Response Code',
        'Response',
        'Bank RRN',
        'BankRefNum',
        'TransID',
        'Bank'
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      for (int i = 0; i < seqDataModel2.response!.length; i++) {
        SeqData2Response item = seqDataModel2.response![i];

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.tRANREFNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.tRADT ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.aCTCODE ?? '');

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue(item.rESPONSE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.bANKRRN ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue(item.bANKREFNUM ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = TextCellValue("${item.tRANSID ?? ''}");
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = TextCellValue(item.bANK ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'IMPS Response details$formattedDate.xlsx';

      if (kIsWeb) {
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: AppColor.drawerColor,
                  content: Text(
                    'Excel file downloaded: $fileName',
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'poppinsRegular'),
                  )),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      loadExcelReport = false;
      notifyListeners();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    } finally {
      loadExcelReport = false;
      notifyListeners();
    }
  }
}
