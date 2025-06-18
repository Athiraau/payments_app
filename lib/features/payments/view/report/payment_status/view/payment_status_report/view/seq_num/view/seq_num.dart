import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../../../../../core/utils/shared/component/widgets/custom_table_theme.dart';
import '../../../../../controller/payment_status_controller.dart';

class SeqNoDataTable1 extends StatelessWidget {
  const SeqNoDataTable1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        final docIdResponse = paymentStatusProvider.seqDataModel1.response;

        if (docIdResponse == null || docIdResponse.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: _tableRowTxtStyle,
            ),
          );
        }

        return CustomTableTheme(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.dividerColor, width: 0.65),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ImpsTransNo')),
                  DataColumn(label: Text('Bank')),
                  DataColumn(label: Text('TraDate')),
                ],
                rows: docIdResponse
                    .asMap()
                    .map((index, e) {
                      Color rowColor =
                          index.isEven ? Colors.white : AppColor.tableRowColor;

                      return MapEntry(
                        index,
                        DataRow(
                          color: MaterialStateProperty.all(rowColor),
                          cells: [
                            DataCell(Text(e.cORPORATEID ?? '')),
                            DataCell(Text(e.bANK ?? '')),
                            DataCell(Text(e.tRADT?.split('T').isNotEmpty == true
                                ? e.tRADT!.split('T')[0]
                                : '')),
                          ],
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SeqNoDataTable2 extends StatelessWidget {
  const SeqNoDataTable2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        final docIdResponse = paymentStatusProvider.seqDataModel2.response;

        if (docIdResponse == null || docIdResponse.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: _tableRowTxtStyle,
            ),
          );
        }

        return CustomTableTheme(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.dividerColor, width: 0.65),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('CorporateId')),
                  DataColumn(label: Text('TraDate')),
                  DataColumn(label: Text('Response Code')),
                  DataColumn(label: Text('Response')),
                  DataColumn(label: Text('Bank RRN')),
                  DataColumn(label: Text('BankRefNum')),
                  DataColumn(label: Text('TransID')),
                  DataColumn(label: Text('Bank')),
                ],
                rows: docIdResponse
                    .asMap()
                    .map((index, e) {
                      Color rowColor =
                          index.isEven ? Colors.white : AppColor.tableRowColor;

                      return MapEntry(
                        index,
                        DataRow(
                          color: WidgetStateProperty.all(rowColor),
                          cells: [
                            DataCell(Text(e.tRANREFNO ?? '')),
                            DataCell(Text(e.tRADT?.split('T').isNotEmpty == true
                                ? e.tRADT!.split('T')[0]
                                : '')),
                            DataCell(Text(e.aCTCODE ?? '')),
                            DataCell(Text(e.rESPONSE ?? '')),
                            DataCell(Text(e.bANKRRN ?? '')),
                            DataCell(Text(e.bANKREFNUM ?? '')),
                            DataCell(Text("${e.tRANSID ?? ''}")),
                            DataCell(Text(e.bANK ?? '')),
                          ],
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SeqNoDataTable3 extends StatelessWidget {
  const SeqNoDataTable3({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        final docIdResponse = paymentStatusProvider.seqDataModel3.response;

        if (docIdResponse == null || docIdResponse.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: _tableRowTxtStyle,
            ),
          );
        }

        return CustomTableTheme(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.dividerColor, width: 0.65),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Unique Ref No')),
                  DataColumn(label: Text('Pay Date')),
                  DataColumn(label: Text('Transaction Auth No')),
                  DataColumn(label: Text('Cheque No')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Status Description')),
                  DataColumn(label: Text('Bank Ref No')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Beneficiary Account No')),
                  DataColumn(label: Text('Transaction Date')),
                  DataColumn(label: Text('Transaction ID')),
                  DataColumn(label: Text('Batch No'))
                ],
                rows: docIdResponse
                    .asMap()
                    .map((index, e) {
                      Color rowColor =
                          index.isEven ? Colors.white : AppColor.tableRowColor;

                      return MapEntry(
                        index,
                        DataRow(
                          color: MaterialStateProperty.all(rowColor),
                          cells: [
                            DataCell(Text(e.uNIQUEREFNO ?? '')),
                            DataCell(Text(e.pAYDATE ?? '')),
                            DataCell(Text(e.tRAUTRNO ?? '')),
                            DataCell(Text(e.cHQNO ?? '')),
                            DataCell(Text(e.sTATUS ?? '')),
                            DataCell(Text(e.sTATUSDESC ?? '')),
                            DataCell(Text(e.bANKREFNO ?? '')),
                            DataCell(Text("${e.aMOUNT ?? ''}")),
                            DataCell(Text(e.bENEFICIARYACCNO ?? '')),
                            DataCell(Text(e.tRADATE ?? '')),
                            DataCell(Text("${e.tRANSID ?? ''}")),
                            DataCell(Text(e.bATCHNO ?? '')),
                          ],
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SeqNoDataTable4 extends StatelessWidget {
  const SeqNoDataTable4({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        final docIdResponse = paymentStatusProvider.seqDataModel4.response;

        if (docIdResponse == null || docIdResponse.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: _tableRowTxtStyle,
            ),
          );
        }

        return CustomTableTheme(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.dividerColor, width: 0.65),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Corporate ID')),
                  DataColumn(label: Text('Branch Name')),
                  DataColumn(label: Text('Branch ID')),
                  DataColumn(label: Text('Document ID')),
                  DataColumn(label: Text('Customer ID')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Value Date')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Received Date')),
                  DataColumn(label: Text('Received By')),
                  DataColumn(label: Text('Transaction ID')),
                ],
                rows: docIdResponse
                    .asMap()
                    .map((index, e) {
                      Color rowColor =
                          index.isEven ? Colors.white : AppColor.tableRowColor;

                      return MapEntry(
                        index,
                        DataRow(
                          color: MaterialStateProperty.all(rowColor),
                          cells: [
                            DataCell(Text(e.cORPORATEID ?? '')),
                            DataCell(Text(e.bRANCHNAME ?? '')),
                            DataCell(Text("${e.bRANCHID ?? ''}")),
                            DataCell(Text(e.dOCID ?? '')),
                            DataCell(Text(e.cUSTID ?? '')),
                            DataCell(Text("${e.aMOUNT ?? ''}")),
                            DataCell(Text(e.vALUEDATE ?? '')),
                            DataCell(Text(e.sTATUS ?? '')),
                            DataCell(Text(e.rECEIVEDDT ?? '')),
                            DataCell(Text("${e.rECEIVEDBY ?? ''}")),
                            DataCell(Text("${e.tRANSID ?? ''}")),
                          ],
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SeqNoDataTable5 extends StatelessWidget {
  const SeqNoDataTable5({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        final docIdResponse = paymentStatusProvider.seqDataModel5.response;

        if (docIdResponse == null || docIdResponse.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: _tableRowTxtStyle,
            ),
          );
        }

        return CustomTableTheme(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.dividerColor, width: 0.65),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Mode Description')),
                  DataColumn(label: Text('Document ID')),
                  DataColumn(label: Text('Customer ID')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Value Date')),
                  DataColumn(label: Text('Corporate ID')),
                  DataColumn(label: Text('Pay Bank')),
                  DataColumn(label: Text('Reinitiate Bank')),
                  DataColumn(label: Text('Reinitiated Date')),
                  DataColumn(label: Text('Reinitiated By')),
                ],
                rows: docIdResponse
                    .asMap()
                    .map((index, e) {
                      Color rowColor =
                          index.isEven ? Colors.white : AppColor.tableRowColor;

                      return MapEntry(
                        index,
                        DataRow(
                          color: MaterialStateProperty.all(rowColor),
                          cells: [
                            DataCell(Text(e.mODDESCR ?? '')),
                            DataCell(Text(e.dOCID ?? '')),
                            DataCell(Text(e.cUSTID ?? '')),
                            DataCell(Text("${e.aMOUNT ?? ''}")),
                            DataCell(Text(e.vALUEDATE ?? '')),
                            DataCell(Text(e.cORPORATEID ?? '')),
                            DataCell(Text(e.pAYBANK ?? '')),
                            DataCell(Text(e.rEINITIATEBANK ?? '')),
                            DataCell(Text(e.rEINITIATEDT ?? '')),
                            DataCell(Text(e.rEINITIATEDBY ?? '')),
                          ],
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

const _tableRowTxtStyle = TextStyle(
    fontFamily: 'poppinsRegular',
    fontSize: 10,
    color: AppColor.cardTitleSubColor);
