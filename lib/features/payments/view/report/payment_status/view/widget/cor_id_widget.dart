import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/config/styles/colors.dart';
import '../../controller/payment_status_controller.dart';
import '../../model/cor_id_model1.dart';
import '../../model/cor_id_model2.dart';

class CorIdWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final PaymentStatusProvider? provider;
  final List<CorIdResponse1>? corId1;
  final List<CorIdResponse2>? corId2;
  const CorIdWidget(
      {super.key,
      this.width,
      this.height,
      this.corId1,
      this.corId2,
      this.provider});

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
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TraDate', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source:
                            CorIdDataSource1(corId1 ?? [], provider, context),
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

class CorIdDataSource1 extends DataTableSource {
  final List<CorIdResponse1> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  CorIdDataSource1(this.data, this.provider, this.context);
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
            Center(child: Text(item.tRADT ?? '-', style: _tableRowTxtStyle))),
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
