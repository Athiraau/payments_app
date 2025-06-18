import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payment_app/features/payments/view/report/payment_status/model/seq_id_5.dart';

import '../../../../../../../core/utils/config/styles/colors.dart';
import '../../controller/payment_status_controller.dart';
import '../../model/seq_id_1.dart';
import '../../model/seq_id_2.dart';
import '../../model/seq_id_3.dart';
import '../../model/seq_id_4.dart';

class SeqNumberWidgets extends StatelessWidget {
  final double? width;
  final double? height;
  final List<Seq1>? seqNum1;
  final List<Seq2>? seqNum2;
  final List<Seq3>? seqNum3;
  final List<Seq4>? seqNum4;
  final List<Seq5>? seqNum5;
  final PaymentStatusProvider? provider;
  const SeqNumberWidgets(
      {super.key,
      this.width,
      this.height,
      this.provider,
      this.seqNum1,
      this.seqNum2,
      this.seqNum3,
      this.seqNum4,
      this.seqNum5});

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
                        minWidth: 600, // Adjusted based on column requirements
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
                        rowsPerPage: provider!.rowsPerPageSeq1,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('ImpsTransNo', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TraDate', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: SequenceDataSource1(
                            seqNum1 ?? [], provider, context),
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
                        rowsPerPage: provider!.rowsPerPageSeq2,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('CorporateId', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TraDate', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Response Code',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Response', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank RRN', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('BankRefNum', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TransID', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: SequenceDataSource2(
                            seqNum2 ?? [], provider, context),
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
                        rowsPerPage: provider!.rowsPerPageSeq3,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child: Text('Unique Ref No',
                                    style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Pay Date', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Transaction Auth No',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Cheque No', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Status', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Status Description',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Bank Ref No', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Amount', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Beneficiary Account No',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Transaction Date',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Transaction ID',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Batch No', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: SequenceDataSource3(
                            seqNum3 ?? [], provider, context),
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
                                child:
                                    Text('Corporate ID', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Branch Name', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Branch ID', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Document ID', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Customer ID', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Amount', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Value Date', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Status', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Received Date',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Received By', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Transaction ID',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: SequenceDataSource4(
                            seqNum4 ?? [], provider, context),
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
                                child: Text('Mode Description',
                                    style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Document ID', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Customer ID', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Amount', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Value Date', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Corporate ID', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Pay Bank', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Reinitiate Bank',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Reinitiated Date',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Reinitiated By',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: SequenceDataSource5(
                            seqNum5 ?? [], provider, context),
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

class SequenceDataSource1 extends DataTableSource {
  final List<Seq1> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  SequenceDataSource1(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.cORPORATEID ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANK ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.tRADT ?? '-', style: _tableRowTxtStyle))),
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

class SequenceDataSource2 extends DataTableSource {
  final List<Seq2> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  SequenceDataSource2(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.tRANREFNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.tRADT ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.aCTCODE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.rESPONSE ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANKRRN ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bANKREFNUM ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.tRANSID ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANK ?? '-', style: _tableRowTxtStyle))),
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

class SequenceDataSource3 extends DataTableSource {
  final List<Seq3> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  SequenceDataSource3(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.uNIQUEREFNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.pAYDATE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.tRAUTRNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.cHQNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.sTATUS ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.sTATUSDESC ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bANKREFNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aMOUNT ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child:
                Text(item.bENEFICIARYACCNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.tRADATE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.tRANSID ?? '-'}", style: _tableRowTxtStyle))),
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

class SequenceDataSource4 extends DataTableSource {
  final List<Seq4> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  SequenceDataSource4(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.cORPORATEID ?? '-', style: _tableRowTxtStyle))),
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
            child: Text("${item.sTATUS ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.rECEIVEDDT ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child:
                Text("${item.rECEIVEDBY ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.tRANSID ?? '-'}", style: _tableRowTxtStyle))),
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

class SequenceDataSource5 extends DataTableSource {
  final List<Seq5> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  SequenceDataSource5(this.data, this.provider, this.context);
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
        DataCell(
            Center(child: Text(item.dOCID ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.cUSTID ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aMOUNT ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.vALUEDATE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.cORPORATEID ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.pAYBANK ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.rEINITIATEBANK ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.rEINITIATEDT ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.rEINITIATEDBY ?? '-', style: _tableRowTxtStyle))),
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
