import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payment_app/features/payments/view/report/payment_status/model/doc_id_1.dart';

import '../../../../../../../core/utils/config/styles/colors.dart';
import '../../controller/payment_status_controller.dart';
import '../../model/doc_id_2.dart';

class DocIdWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final List<DocId1>? docId1;
  final List<DocId2>? docId2;
  final PaymentStatusProvider? provider;
  const DocIdWidget(
      {super.key,
      this.width,
      this.height,
      this.docId1,
      this.provider,
      this.docId2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          height: 270,
          child: Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    height: 220,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFFCCC6C6)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        cardTheme: CardTheme(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      child: PaginatedDataTable2(
                        scrollController:
                            ScrollController(), // Enable scrolling
                        minWidth: 2000, // Adjusted based on column requirements
                        headingRowHeight: 35.0,
                        dataRowHeight: 40.0,
                        horizontalMargin: 16,
                        columnSpacing: 16,
                        wrapInCard: false,
                        headingRowColor: WidgetStateProperty.all(
                          const Color(0xFF112D4E),
                        ),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        dataTextStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 13,
                        ),
                        dividerThickness: 0.5,
                        rowsPerPage: provider!.rowsPerPageSeq4,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child: Text('Module', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Branch', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('BranchId', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('DocId', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('CustomerId', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Amount', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TraDate', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('SendDate', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('SendTransId', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('CorporateId', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('BatchNumber', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source:
                            DocIdDataSource1(docId1 ?? [], provider, context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        SizedBox(
          width: width,
          height: 270,
          child: Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    height: 220,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFFCCC6C6)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        cardTheme: CardTheme(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      child: PaginatedDataTable2(
                        scrollController:
                            ScrollController(), // Enable scrolling
                        minWidth: 2000, // Adjusted based on column requirements
                        headingRowHeight: 35.0,
                        dataRowHeight: 40.0,
                        horizontalMargin: 16,
                        columnSpacing: 16,
                        wrapInCard: false,
                        headingRowColor: WidgetStateProperty.all(
                          const Color(0xFF112D4E),
                        ),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        dataTextStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 13,
                        ),
                        dividerThickness: 0.5,
                        rowsPerPage: provider!.rowsPerPageSeq4,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child: Text('Customer Name',
                                    style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Account Number',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('IFSC Code', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Status', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('CustRefId', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source:
                            DocIdDataSource2(docId2 ?? [], provider, context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}

class DocIdDataSource1 extends DataTableSource {
  final List<DocId1> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  DocIdDataSource1(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.mODDESCR ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bRANCHNAME ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.bRANCHID ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.dOCID ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.cUSTID ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aMOUNT ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.vALUEDATE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.sENDDATE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child:
                Text("${item.sENDTRANSID ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.cORPORATEID ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bATCHNO ?? '-', style: _tableRowTxtStyle))),
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

class DocIdDataSource2 extends DataTableSource {
  final List<DocId2> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  DocIdDataSource2(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.cUSTNAME ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bENEFICIARYACCOUNT ?? '-',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.iFSCCODE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bANKNAME ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.sTATUS ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.cUSTID ?? '-', style: _tableRowTxtStyle))),
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

const _tableRowTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  color: AppColor.cardTitleSubColor,
);
const _tableRowHead = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  color: Colors.white,
);
