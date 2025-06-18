import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../../../../../core/utils/shared/component/widgets/custom_table_theme.dart';
import '../../../../../controller/payment_status_controller.dart';

class DocIdDataTable1 extends StatelessWidget {
  const DocIdDataTable1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentStatusProvider>(
      builder: (context, paymentStatusProvider, child) {
        final docIdResponse = paymentStatusProvider.docIdModel1.docId1response;

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
                rows: docIdResponse.asMap().map((index, e) {
                  Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;

                  return MapEntry(
                    index,
                    DataRow(
                      color: MaterialStateProperty.all(rowColor),
                      cells: [
                        DataCell(Text(e.mODDESCR ?? '')),
                        DataCell(Text(e.bRANCHNAME ?? '')),
                        DataCell(Text("${e.bRANCHID ?? ''}")),
                        DataCell(Text(e.dOCID ?? '')),
                        DataCell(Text(e.cUSTID ?? '')),
                        DataCell(Text("${e.aMOUNT ?? ''}")),
                        DataCell(Text(e.vALUEDATE?.split('T').isNotEmpty == true
                            ? e.vALUEDATE!.split('T')[0]
                            : '')),
                        DataCell(Text(e.sENDDATE?.split('T').isNotEmpty == true
                            ? e.sENDDATE!.split('T')[0]
                            : '')),
                        DataCell(Text(e.sENDTRANSID ?? '')),
                        DataCell(Text(e.cORPORATEID ?? '')),
                        DataCell(Text(e.bATCHNO ?? '')),
                      ],
                    ),
                  );
                }).values.toList(),
              ),
            ),
          ),
        );
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
        final docIdResponse = paymentStatusProvider.docIdModel2.docId2response;

        if (docIdResponse == null) {
          return const Center(child: Text('No data available',style: _tableRowTxtStyle,));
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
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Account Number')),
                  DataColumn(label: Text('IFSC Code')),
                  DataColumn(label: Text('Bank')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('CustRefId')),
                ],
                rows: docIdResponse.asMap().map((index, e) {
                  Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;

                  // Handle potential null values in the data
                  return MapEntry(
                    index,
                    DataRow(
                      color: MaterialStateProperty.all(rowColor),
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
                }).values.toList(),
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