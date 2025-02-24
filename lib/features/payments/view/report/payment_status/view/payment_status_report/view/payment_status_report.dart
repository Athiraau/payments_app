import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/features/payments/view/report/payment_status/controller/payment_status_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../../../model/doc_id_model1.dart';
import '../../../model/doc_id_model2.dart';
import '../../../model/pay_status_table_model.dart';

class PaymentStatusReport extends StatelessWidget {
  const PaymentStatusReport({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        paymentStatusProvider.setCurBranchName();
        return Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsPath.appBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BreadCrumbs(
                  title: 'Payment Status Report',
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                      width: size.width,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        border:
                            Border.all(width: 1, color: AppColor.dividerColor),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Consumer<PaymentStatusProvider>(
                        builder: (context, paymentStatusProvider, child) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: size.width * 0.15,
                                      child: IconButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        icon: const Icon(
                                          color: AppColor.drawerColor,
                                          Icons.arrow_back,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: CustomText(
                                          text: paymentStatusProvider.branchName
                                              .toUpperCase(),
                                          fontSize: isTablet ? 16 : 12,
                                          fontFamily: 'poppinsSemiBold',
                                          color: AppColor.hdTxtColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: size.width * 0.15,
                                      child: CustomText(
                                        text: isTablet
                                            ? "${paymentStatusProvider.formattedDate}, ${paymentStatusProvider.formattedTime}"
                                            : "${paymentStatusProvider.formattedDate},\n${paymentStatusProvider.formattedTime}",
                                        fontSize: isTablet ? 12 : 10,
                                        fontFamily: 'poppinsRegular',
                                        color: AppColor.hdTxtColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView(
                                      scrollDirection: Axis.vertical,
                                      children: [
                                    if (paymentStatusProvider
                                            .payStatusTableModel.response !=
                                        null)
                                      paymentStatusProvider.payStatusTableModel
                                              .response!.isNotEmpty
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomButton(
                                                    progress: paymentStatusProvider
                                                            .loadExcelReport
                                                        ? const SizedBox(
                                                            width: 10,
                                                            height: 10,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ))
                                                        : null,
                                                    customWidget:
                                                        SvgPicture.asset(
                                                      AssetsPath.excel,
                                                      width: 18,
                                                      height: 18,
                                                      color: Colors.white,
                                                    ),
                                                    text: 'Export to Excel',
                                                    txtColor: Colors.white,
                                                    btnColor: AppColor.excelBtn,
                                                    borderRadious: 8,
                                                    width: 143,
                                                    height: 38,
                                                    onPressed: () {
                                                      paymentStatusProvider
                                                          .exportToExcel(
                                                              context);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomButton(
                                                    customWidget:
                                                        SvgPicture.asset(
                                                      AssetsPath.pdf,
                                                      width: 18,
                                                      height: 18,
                                                      color: Colors.white,
                                                    ),
                                                    text: 'Export to Pdf',
                                                    txtColor:
                                                        AppColor.primaryColor,
                                                    btnColor: AppColor.pdfBtn,
                                                    borderRadious: 8,
                                                    width: 143,
                                                    height: 40,
                                                    onPressed: () {
                                                      paymentStatusProvider
                                                          .exportToPdf(context);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomButton(
                                                    text: 'Exit',
                                                    txtColor: Colors.white,
                                                    btnColor: AppColor
                                                        .drawerImgTileColor,
                                                    borderRadious: 8,
                                                    width: 143,
                                                    height: 38,
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    paymentStatusProvider.isLoading
                                        ? _buildShimmerList()
                                        : paymentStatusProvider
                                                .payStatusTableModel
                                                .response!
                                                .isNotEmpty
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: Theme(
                                                  data: ThemeData(
                                                    cardTheme: CardTheme(
                                                      color: AppColor
                                                          .tableHeaderColor,
                                                      elevation: 8,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dataTableTheme:
                                                        DataTableThemeData(
                                                      headingTextStyle:
                                                          _headTxtStyle,
                                                      dataRowColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                      dataTextStyle:
                                                          _tableRowTxtStyle,
                                                      dividerThickness: 0,
                                                      dataRowMaxHeight: 56,
                                                      columnSpacing: 12,
                                                      horizontalMargin: 12.0,
                                                      dataRowMinHeight: 0,
                                                    ),
                                                    textTheme: const TextTheme(
                                                        bodySmall: TextStyle(
                                                            color: AppColor
                                                                .card5)),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: PaginatedDataTable(
                                                      arrowHeadColor:
                                                          AppColor.primaryColor,
                                                      header: null,
                                                      columns: const [
                                                        DataColumn(
                                                            label:
                                                                Text('Module')),
                                                        DataColumn(
                                                            label:
                                                                Text('Branch')),
                                                        DataColumn(
                                                            label: Text(
                                                                'BranchId')),
                                                        DataColumn(
                                                            label:
                                                                Text('DocId')),
                                                        DataColumn(
                                                            label: Text(
                                                                'CustomerId')),
                                                        DataColumn(
                                                            label:
                                                                Text('Amount')),
                                                        DataColumn(
                                                            label: Text(
                                                                'TraDate')),
                                                        DataColumn(
                                                            label: Text(
                                                                'SendDate')),
                                                        DataColumn(
                                                            label: Text(
                                                                'SendTransId')),
                                                        DataColumn(
                                                            label: Text(
                                                                'CorporateId')),
                                                        DataColumn(
                                                            label: Text(
                                                                'BatchNumber')),
                                                        DataColumn(
                                                            label: Text(
                                                                'BeneName')),
                                                        DataColumn(
                                                            label: Text(
                                                                'BeneAccNo')),
                                                        DataColumn(
                                                            label: Text(
                                                                'BeneIFSCCode')),
                                                        DataColumn(
                                                            label: Text(
                                                                'SeqNumber')),
                                                      ],
                                                      source: TableDataSource(
                                                          paymentStatusProvider
                                                              .payStatusTableModel
                                                              .response!
                                                              .cast<Response>(),
                                                          context),
                                                      rowsPerPage:
                                                          paymentStatusProvider
                                                              .rowsPerPage,
                                                      availableRowsPerPage: [
                                                        5,
                                                        10,
                                                        20
                                                      ],
                                                      onRowsPerPageChanged:
                                                          (value) {
                                                        paymentStatusProvider
                                                            .updateRowsPage(
                                                                data: int.parse(
                                                                    value
                                                                        .toString()));
                                                      },
                                                      showCheckboxColumn: false,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: CustomText(
                                                    text: isTablet
                                                        ? "No data found"
                                                        : "No data found",
                                                    fontSize:
                                                        isTablet ? 12 : 10,
                                                    fontFamily:
                                                        'poppinsRegular',
                                                    color: AppColor.hdTxtColor,
                                                  ),
                                                ),
                                              ),
                                  ]))
                            ],
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TableDataSource extends DataTableSource {
  final List<Response> data;
  final BuildContext context;
  TableDataSource(List<Response>? data, this.context) : data = data ?? [];

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return const DataRow(cells: [
        DataCell(Text('No data available',
            style: TextStyle(
                fontStyle: FontStyle.italic, color: AppColor.errorTxt))),
      ]);
    }

    final row = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow(
      color: MaterialStateProperty.all(rowColor),
      cells: [
        DataCell(Text(row.mODDESCR ?? '')),
        DataCell(Text(row.bRANCHNAME ?? '')),
        DataCell(Text("${row.bRANCHID ?? ''}")),
        DataCell(
          InkWell(
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final paymentStatusProvider =
                    Provider.of<PaymentStatusProvider>(context, listen: false);
                paymentStatusProvider.fetchDocIdData1(
                  context: context,
                  docId: row.dOCID ?? '',
                );
                paymentStatusProvider.fetchDocIdData2(
                  context: context,
                  docId: row.dOCID ?? '',
                );
                Future.microtask(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColor.primaryColor,
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: CustomText(
                                    text: "Transaction Details",
                                    fontSize: 14,
                                    fontFamily: 'poppinsSemiBold',
                                    color: AppColor.appBarColor,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DocIdDataTable1(),
                                  ),
                                ),
                                Center(
                                  child: CustomText(
                                    text: "Neft Customer Details",
                                    fontSize: 14,
                                    fontFamily: 'poppinsSemiBold',
                                    color: AppColor.appBarColor,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DocIdDataTable2(),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     'Teachers',
                                //     style: TextStyle(
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.drawerImgTileColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  context.pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    'Close',
                                    style: const TextStyle(
                                      color: Colors.white,
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
                });
              });
            },
            child: Text(
              row.dOCID ?? '',
              style: _highLiteTxtStyle,
            ),
          ),
        ),
        DataCell(Text(row.cUSTID ?? '')),
        DataCell(Text("${row.aMOUNT ?? ''}")),
        DataCell(Text(row.vALUEDATE ?? '')),
        DataCell(Text(row.sENDDATE ?? '')),
        DataCell(Text(row.sENDTRANSID ?? '')),
        DataCell(Text(row.cORPORATEID ?? '')),
        DataCell(Text(row.bATCHNO ?? '')),
        DataCell(Text(row.cUSTNAME ?? '')),
        DataCell(Text(row.bENEFICIARYACCOUNT ?? '')),
        DataCell(Text(row.iFSCCODE ?? '')),
        DataCell(Text(row.sEQNO ?? '')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class DocIdDataTable1 extends StatelessWidget {
  const DocIdDataTable1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        return Theme(
            data: ThemeData(
              cardTheme: CardTheme(
                color: AppColor.tableHeaderColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dataTableTheme: DataTableThemeData(
                headingTextStyle: _headTxtStyle2,
                dataRowColor: MaterialStateProperty.all(Colors.white),
                dataTextStyle: _tableRowTxtStyle,
                dividerThickness: 0,
                dataRowMaxHeight: 56,
                columnSpacing: 60,
                horizontalMargin: 30.0,
                dataRowMinHeight: 15,
              ),
              textTheme:
                  const TextTheme(bodySmall: TextStyle(color: AppColor.card5)),
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Module')),
                DataColumn(label: Text('Branch')),
                DataColumn(label: Text('BranchId')),
                DataColumn(label: Text('DocId')),
                DataColumn(label: Text('CustomerId')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('TraDate')),
                DataColumn(label: Text('SendDate')),
                DataColumn(label: Text('SendTransId')),
                DataColumn(label: Text('CorporateId')),
                DataColumn(label: Text('BatchNumber')),
              ],
              rows: paymentStatusProvider.docIdModel1.docId1response!
                  .asMap() // Convert the list to a map to get the index
                  .map((index, e) {
                    Color rowColor = index.isEven
                        ? Colors.white
                        : AppColor
                            .tableRowColor; // Set row color based on index
                    return MapEntry(
                      index,
                      DataRow(
                        color: MaterialStateProperty.all(
                            rowColor), // Set the row color
                        cells: [
                          DataCell(Text(e.mODDESCR ?? '')),
                          DataCell(Text(e.bRANCHNAME ?? '')),
                          DataCell(Text("${e.bRANCHID ?? ''}")),
                          DataCell(Text(e.dOCID ?? '')),
                          DataCell(Text(e.cUSTID ?? '')),
                          DataCell(Text("${e.aMOUNT ?? ''}")),
                          DataCell(Text(e.vALUEDATE ?? '')),
                          DataCell(Text(e.sENDDATE ?? '')),
                          DataCell(Text(e.sENDTRANSID ?? '')),
                          DataCell(Text(e.cORPORATEID ?? '')),
                          DataCell(Text(e.bATCHNO ?? '')),
                        ],
                      ),
                    );
                  })
                  .values // Get the list of DataRow objects
                  .toList(),
            ));
      },
    );
  }
}

class DocIdDataTable2 extends StatelessWidget {
  const DocIdDataTable2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        return Theme(
            data: ThemeData(
              cardTheme: CardTheme(
                color: AppColor.tableHeaderColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dataTableTheme: DataTableThemeData(
                headingTextStyle: _headTxtStyle2,
                dataRowColor: MaterialStateProperty.all(Colors.white),
                dataTextStyle: _tableRowTxtStyle,
                dividerThickness: 0,
                dataRowMaxHeight: 56,
                columnSpacing: 60,
                horizontalMargin: 30.0,
                dataRowMinHeight: 15,
              ),
              textTheme:
                  const TextTheme(bodySmall: TextStyle(color: AppColor.card5)),
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Customer Name')),
                DataColumn(label: Text('Account Number')),
                DataColumn(label: Text('IFSC Code')),
                DataColumn(label: Text('Bank')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('CustRefId')),
              ],
              rows: paymentStatusProvider.docIdModel2.docId2response!
                  .asMap() // Convert the list to a map to get the index
                  .map((index, e) {
                    Color rowColor = index.isEven
                        ? Colors.white
                        : AppColor
                            .tableRowColor; // Set row color based on index
                    return MapEntry(
                      index,
                      DataRow(
                        color: MaterialStateProperty.all(
                            rowColor), // Set the row color
                        cells: [
                          DataCell(Text(e.cUSTNAME ?? '')),
                          DataCell(Text(e.bENEFICIARYACCOUNT ?? '')),
                          DataCell(Text(e.iFSCCODE ?? '')),
                          DataCell(Text(e.bANKNAME ?? '')),
                          DataCell(Text(e.sTATUS ?? '')),
                          DataCell(Text(e.cUSTID ?? '')),
                        ],
                      ),
                    );
                  })
                  .values // Get the list of DataRow objects
                  .toList(),
            ));
      },
    );
  }
}

const _tableRowTxtStyle = TextStyle(
    fontFamily: 'poppinsRegular',
    fontSize: 10,
    color: AppColor.cardTitleSubColor);

const _headTxtStyle = TextStyle(
  fontFamily: 'poppinsSemiBold',
  fontSize: 10,
  color: AppColor.primaryColor,
);
const _headTxtStyle2 = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  color: AppColor.cardTitleSubColor,
);
const _highLiteTxtStyle = TextStyle(
  shadows: [Shadow(color: AppColor.highLiteTxt, offset: Offset(0, -5))],
  color: Colors.transparent,
  decoration: TextDecoration.underline,
  decorationColor: AppColor.dividerColor,
  decorationThickness: 4,
  decorationStyle: TextDecorationStyle.dashed,
);

Widget _buildShimmerList() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 80,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 16.0),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 25,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 20,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
