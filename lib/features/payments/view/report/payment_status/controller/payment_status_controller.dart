import 'dart:async';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payments_application/core/utils/config/styles/colors.dart';
import 'package:payments_application/core/utils/shared/constant/assets_path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/pay_status_table_model.dart';
import '../repository/payment_status_repository.dart';
import 'dart:html' as html;

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
    }
  }

  bool loadExcelReport = false;

  Future<void> exportToExcel(BuildContext context) async {
    try {
      loadExcelReport = true;
      notifyListeners();

      if (payStatusTableModel.response!.isEmpty &&
          payStatusTableModel.response != null) {
        // Handle empty data case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data to export')),
        );
        return;
      }

      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        'MOD DESCR',
        'Branch name',
        'Branch id',
        'Doc Id',
        'Customer Id',
        'Amount',
        'Value date',
        'Send date',
        'Send transaction Id',
        'Co-operate Id',
        'Batch Number',
        'Customer name',
        'Beneficiary account',
        'IFSC Code',
        'SEQ Number'
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      // Add data
      for (int i = 0; i < payStatusTableModel.response!.length; i++) {
        Response item = payStatusTableModel.response![i];
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
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
            .value = TextCellValue(item.cUSTNAME ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1))
            .value = TextCellValue(item.bENEFICIARYACCOUNT ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1))
            .value = TextCellValue(item.iFSCCODE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i + 1))
            .value = TextCellValue(item.sEQNO ?? '');
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
    if (payStatusTableModel.response!.isEmpty) {
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
      'MOD DESCR',
      'Branch name',
      'Branch id',
      'Doc Id',
      'Customer Id',
      'Amount',
      'Value date',
      'Send date',
      'Send transaction Id',
      'Co-operate Id',
      'Batch Number',
      'Customer name',
      'Beneficiary account',
      'IFSC Code',
      'SEQ Number'
    ];

    List<List<String>> tableData = payStatusTableModel.response!.map((item) {
      return [
        item.mODDESCR ?? '',
        item.bRANCHNAME ?? '',
        "${item.bRANCHID ?? ''}",
        item.dOCID ?? '',
        item.cUSTID ?? '',
        "${item.aMOUNT ?? ''}",
        item.vALUEDATE ?? '',
        item.sENDDATE ?? '',
        item.sENDTRANSID ?? '',
        item.cORPORATEID ?? '',
        item.bATCHNO ?? '',
        item.cUSTNAME ?? '',
        item.bENEFICIARYACCOUNT ?? '',
        item.iFSCCODE ?? '',
        item.sEQNO ?? ''
      ];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        header: (pw.Context context) {
          return pw.Column(children: [pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(
                    height: 25,
                    width: 100,
                    child: pw.Image(image, fit: pw.BoxFit.fill)),
              ]),pw.SizedBox(height: 10)]);
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
                font: poppinsSemiBold),
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
    String fileName = 'payments_report_$formattedDate.pdf';

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
}
