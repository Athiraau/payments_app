import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../model/imps_inquiry_model.dart';
import '../repository/imps_inquiry_repository.dart';

class ImpsInquiryProvider extends ChangeNotifier {
  ImpsInquiryProvider() {
    formatDateTime();
  }
  String _branchName = '';
  TextEditingController searchController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController searchModule = TextEditingController();
  TextEditingController searchPaymentType = TextEditingController();
  TextEditingController searchBranch = TextEditingController();
  TextEditingController searchPaymentBank = TextEditingController();
  TextEditingController searchStatus = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  void clearFields() {
    searchController.clear();
    textController.clear();
    searchModule.clear();
    searchPaymentType.clear();
    searchBranch.clear();
    searchPaymentBank.clear();
    searchStatus.clear();
    fromDateController.clear();
    toDateController.clear();
    notifyListeners();
  }
  String curDocTitle = 'Corporate ID';
  String _selectedOption = 'Corporate ID';

  String get branchName => _branchName;

  set branchName(String value) {
    _branchName = value;
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
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

  List<Map<String, dynamic>> modules = [
    {"id": 1, "name": "Module 1"},
    {"id": 2, "name": "Module 2"},
    {"id": 3, "name": "Module 3"},
    {"id": 4, "name": "Module 4"},
    {"id": 5, "name": "Module 5"},
    {"id": 6, "name": "Module 6"},
  ];

  var selectedModule = '';

  List<Map<String, dynamic>> paymentType = [
    {"id": 1, "name": "Payment type 1"},
    {"id": 2, "name": "Payment type 2"},
    {"id": 3, "name": "Payment type 3"},
    {"id": 4, "name": "Payment type 4"},
    {"id": 5, "name": "Payment type 5"},
    {"id": 6, "name": "Payment type 6"},
  ];
  var selectedPaymentType = '';

  List<Map<String, dynamic>> paymentBank = [
    {"id": 1, "name": "Payment bank 1"},
    {"id": 2, "name": "Payment bank 2"},
    {"id": 3, "name": "Payment bank 3"},
    {"id": 4, "name": "Payment bank 4"},
    {"id": 5, "name": "Payment bank 5"},
    {"id": 6, "name": "Payment bank 6"},
  ];
  var selectedPaymentBank = '';

  List<Map<String, dynamic>> branch = [
    {"id": 1, "name": "Branch 1"},
    {"id": 2, "name": "Branch 2"},
    {"id": 3, "name": "Branch 3"},
    {"id": 4, "name": "Branch 4"},
    {"id": 5, "name": "Branch 5"},
    {"id": 6, "name": "Branch 6"},
  ];
  var selectedBranch = '';

  List<Map<String, dynamic>> status = [
    {"id": 1, "name": "Status 1"},
    {"id": 2, "name": "Status 2"},
    {"id": 3, "name": "Status 3"},
    {"id": 4, "name": "Status 4"},
    {"id": 5, "name": "Status 5"},
    {"id": 6, "name": "Status 6"},
  ];
  var selectedStatus = '';

  DateTime? _fromDate;
  DateTime? get fromDate => _fromDate;

  void setFromDate(DateTime date) {
    _fromDate = date;
    notifyListeners();
  }

  DateTime? _toDate;
  DateTime? get toDate => _toDate;

  void setToDate(DateTime date) {
    _toDate = date;
    notifyListeners();
  }

  var filteredItems = <ImpsInquiryModel>[];
  void searchItems(String query) {
    if (query.isEmpty) {
      filteredItems = List.from(impsReportList);
    } else {
      filteredItems = filteredItems
          .where((item) =>
              item.mODDESCR
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.branchName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.branchId
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.sEQNumber
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
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

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      final DateFormat dateFormat = DateFormat('MMM d, yyyy');
      final DateFormat timeFormat = DateFormat('hh:mm a');

      formattedDate = dateFormat.format(now);
      formattedTime = timeFormat.format(now);

      notifyListeners();
    });
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

  //dummy data
  var impsReportList = <ImpsInquiryModel>[];
  List<Map<String, dynamic>> items = List.generate(100, (index) {
    return {
      'MOD DESCR': 'Transaction ${index + 1}',
      'Branch name': 'Branch ${index + 1}',
      'Branch id': 'BR00${index + 1}',
      'Doc Id': 'DOC${1000 + index + 1}',
      'Customer Id': 'CUST${2000 + index}',
      'Amount': '${(index + 1) * 1000.50}',
      'Value date': '2025-01-${10 + index}',
      'Send date': '2025-01-${9 + index}',
      'Send transaction Id': 'TXN${900000000 + index}',
      'Co-operate Id': 'COOP${3000 + index}',
      'Batch Number': 'BATCH2025${10 + index}',
      'Customer name': 'Customer ${index + 1}',
      'Beneficiary account': '1234567890${index + 1}',
      'IFSC Code': 'BANK000${100 + index}',
      'SEQ Number': 'SEQ${index + 1}',
    };
  });

  final _api = ImpsInquiryRepository();
  var impsInquiryModel = ImpsInquiryModel();

  Future<void> fetchImpsData(
      {required BuildContext context, required String id}) async {
    try {
      isLoading = true;
      notifyListeners();

      final List<dynamic> response = items;
      impsReportList.addAll(
          response.map((json) => ImpsInquiryModel.fromJson(json)).toList());
      filteredItems = impsReportList;
      notifyListeners();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed(RoutesName.impsInquiryReport);
      });
      notifyListeners();

      //   if (response != null && response['status'] == 200) {
      //     if (response['data']['response'] != null) {
      //       ImpsTableModels = ImpsTableModel.fromJson(response['data']);
      //       WidgetsBinding.instance.addPostFrameCallback((_) {
      //         context.goNamed(RoutesName.impsInquiryReport);
      //       });
      //       notifyListeners();
      //     } else {
      //       CustomToast.showCustomErrorToast(message: "response is empty");
      //     }
      //   } else {
      //     CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
      //     notifyListeners();
      //   }
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool loadExcelReport = false;

  Future<void> exportToExcel(BuildContext context) async {
    try {
      loadExcelReport = true;
      notifyListeners();

      if (impsReportList.isEmpty) {
        // Handle empty data case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data to export')),
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
        'BeneName',
        'BeneAccNo',
        'BeneIFSCCode',
        'SeqNumber'
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      // Add data
      for (int i = 0; i < impsReportList.length; i++) {
        ImpsInquiryModel item = impsReportList[i];

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.mODDESCR ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.branchName ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.branchId ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue(item.docId ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.customerId ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue('${item.amount ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = TextCellValue(item.valueDate ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = TextCellValue(item.sendDate ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
            .value = TextCellValue(item.sendTransactionId ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
            .value = TextCellValue(item.coOperateId ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
            .value = TextCellValue(item.batchNumber ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
            .value = TextCellValue(item.customerName ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1))
            .value = TextCellValue(item.beneficiaryAccount ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1))
            .value = TextCellValue(item.iFSCCode ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i + 1))
            .value = TextCellValue(item.sEQNumber ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'payments_report_$formattedDate.xlsx';

      if (kIsWeb) {
        // Web: Trigger browser download
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
              SnackBar(content: Text('Excel file downloaded: $fileName')),
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
          final bytes = await excel.encode();
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

  //export to pdf
  Future<void> exportToPdf(BuildContext context) async {
    if (impsReportList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data to export')),
      );
      return;
    }

    final pdf = pw.Document();
    final ByteData imageData = await rootBundle.load(
      AssetsPath.appLogo,
    );
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);
    final fontDataBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    final poppinsBold = pw.Font.ttf(fontDataBold);
    final fontDataSemiBold =
        await rootBundle.load("assets/fonts/Poppins-SemiBold.ttf");
    final poppinsSemiBold = pw.Font.ttf(fontDataSemiBold);
    final fontDataRegular =
        await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final poppinsRegular = pw.Font.ttf(fontDataRegular);
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
      'BeneName',
      'BeneAccNo',
      'BeneIFSCCode',
      'SeqNumber'
    ];

    List<List<String>> tableData = impsReportList.map((item) {
      return [
        item.mODDESCR ?? '',
        item.branchName ?? '',
        "${item.branchId ?? ''}",
        item.docId ?? '',
        item.customerId ?? '',
        "${item.amount ?? ''}",
        item.valueDate ?? '',
        item.sendDate ?? '',
        item.sendTransactionId ?? '',
        item.coOperateId ?? '',
        item.batchNumber ?? '',
        item.customerName ?? '',
        item.beneficiaryAccount ?? '',
        item.iFSCCode ?? '',
        item.sEQNumber ?? ''
      ];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        header: (pw.Context context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(
                      height: 25,
                      width: 100,
                      child: pw.Image(image, fit: pw.BoxFit.fill)),
                ]),
            pw.SizedBox(height: 10)
          ]);
        },
        footer: (pw.Context context) {
          return pw.Text(
            'Page ${context.pageNumber}',
            style: pw.TextStyle(fontSize: 10, font: poppinsRegular),
            textAlign: pw.TextAlign.right,
          );
        },
        build: (pw.Context context) => [
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: tableData,
            cellAlignment: pw.Alignment.center,
            headerStyle: pw.TextStyle(
                fontSize: 6,
                color: const PdfColor.fromInt(0xFF051645),
                fontWeight: pw.FontWeight.bold,
                font: poppinsRegular),
            cellStyle: pw.TextStyle(
              fontSize: 6,
              font: poppinsRegular,
            ),
            border: pw.TableBorder.all(width: 0.5),
          ),
        ],
      ),
    );

    String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
    String fileName = 'imps_report_$formattedDate.pdf';

    if (kIsWeb) {
      final bytes = await pdf.save();
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'PDF file downloaded: $fileName',
            style: const TextStyle(fontSize: 12, fontFamily: 'poppinsRegular'),
          )),
        );
      });
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        String filePath = '/storage/emulated/0/Download/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              'PDF file saved to: $filePath',
              style:
                  const TextStyle(fontSize: 12, fontFamily: 'poppinsRegular'),
            )),
          );
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Storage permission denied',
              style:
                  const TextStyle(fontSize: 12, fontFamily: 'poppinsRegular'),
            )),
          );
        });
      }
    }
  }

  //file picker
  PlatformFile? _profilePhoto;

  PlatformFile? get profilePhoto => _profilePhoto;
}
