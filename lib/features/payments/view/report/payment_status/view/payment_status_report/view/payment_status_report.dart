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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      child: Container(
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          border: Border.all(
                                              width: 1,
                                              color: AppColor.dividerColor),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            title: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.sort,
                                                    size: 20,
                                                    color: AppColor
                                                        .cardTitleSubColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomText(
                                                    text: "Filter",
                                                    fontSize: isTablet ? 12 : 9,
                                                    fontFamily:
                                                        'poppinsRegular',
                                                    color: AppColor
                                                        .cardTitleSubColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: [
                                              SizedBox(
                                                width: size.width,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      for (String label in [
                                                        "Module",
                                                        "Payment Type",
                                                        "Payment Bank",
                                                        "Branch",
                                                        "Status"
                                                      ])
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: CustomText(
                                                                text: label,
                                                                fontSize:
                                                                    isTablet
                                                                        ? 12
                                                                        : 9,
                                                                fontFamily:
                                                                    'poppinsRegular',
                                                                color: AppColor
                                                                    .cardTitleSubColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                            customWidget: SvgPicture.asset(
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
                                            onPressed: () {},
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomButton(
                                            customWidget: SvgPicture.asset(
                                              AssetsPath.pdf,
                                              width: 18,
                                              height: 18,
                                              color: Colors.white,
                                            ),
                                            text: 'Export to Pdf',
                                            txtColor: AppColor.primaryColor,
                                            btnColor: AppColor.pdfBtn,
                                            borderRadious: 8,
                                            width: 143,
                                            height: 40,
                                            onPressed: () {},
                                          )
                                        ],
                                      ),
                                    ),
                                   paymentStatusProvider.isLoading
                                            ? _buildShimmerList()
                                            : Padding(
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
                                                    textTheme: TextTheme(
                                                        caption: TextStyle(
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
                                                            label: Text(
                                                                'MOD DESCR')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Branch name')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Branch id')),
                                                        DataColumn(
                                                            label:
                                                                Text('Doc Id')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Customer Id')),
                                                        DataColumn(
                                                            label:
                                                                Text('Amount')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Value date')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Send date')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Send transaction Id')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Co-operate Id')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Batch Number')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Customer name')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Beneficiary account')),
                                                        DataColumn(
                                                            label: Text(
                                                                'IFSC Code')),
                                                        DataColumn(
                                                            label: Text(
                                                                'SEQ Number')),
                                                      ],
                                                      source: TableDataSource(
                                                          paymentStatusProvider
                                                              .payStatusTableModel
                                                              .response!
                                                              .cast<
                                                                  Response>()),
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

  TableDataSource(List<Response>? data) : data = data ?? [];

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return DataRow(cells: [
        DataCell(Text('No data available',
            style: TextStyle(fontStyle: FontStyle.italic,color: AppColor.errorTxt))),
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
        DataCell(Text(row.dOCID ?? '')),
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

final _tableRowTxtStyle = TextStyle(
    fontFamily: 'poppinsRegular',
    fontSize: 10,
    color: AppColor.cardTitleSubColor);

final _headTxtStyle = TextStyle(
  fontFamily: 'poppinsSemiBold',
  fontSize: 13,
  color: AppColor.primaryColor,
);
