// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../../../../../../core/utils/config/styles/colors.dart';
// import '../../../../../../../../../../core/utils/shared/component/widgets/custom_table_theme.dart';
// import '../../../../../controller/payment_status_controller.dart';
//
// class CorIdDataTable1 extends StatelessWidget {
//   const CorIdDataTable1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PaymentStatusProvider>(
//       builder: (context, paymentStatusProvider, child) {
//         final docIdResponse = paymentStatusProvider.corIdDataModel1.response;
//
//         if (docIdResponse == null || docIdResponse.isEmpty) {
//           return Center(
//             child: Text(
//               "No data found",
//               style: _tableRowTxtStyle,
//             ),
//           );
//         }
//
//         return CustomTableTheme(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColor.dividerColor, width: 0.65),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: DataTable(
//                 columns: const [
//                   DataColumn(label: Text('ImpsTransNo')),
//                   DataColumn(label: Text('TraDate')),
//                   DataColumn(label: Text('Bank')),
//                 ],
//                 rows: docIdResponse
//                     .asMap()
//                     .map((index, e) {
//                       Color rowColor =
//                           index.isEven ? Colors.white : AppColor.tableRowColor;
//
//                       return MapEntry(
//                         index,
//                         DataRow(
//                           color: MaterialStateProperty.all(rowColor),
//                           cells: [
//                             DataCell(Text(e.cORPORATEID ?? '')),
//                             DataCell(Text(e.tRADT?.split('T').isNotEmpty == true
//                                 ? e.tRADT!.split('T')[0]
//                                 : '')),
//                             DataCell(Text(e.bANK ?? '')),
//                           ],
//                         ),
//                       );
//                     })
//                     .values
//                     .toList(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CorIdDataTable2 extends StatelessWidget {
//   const CorIdDataTable2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PaymentStatusProvider>(
//       builder: (context, paymentStatusProvider, child) {
//         final docIdResponse = paymentStatusProvider.corIDdataModel2.response;
//
//         if (docIdResponse == null || docIdResponse.isEmpty) {
//           return const Center(
//             child: Text(
//               "No data found",
//               style: _tableRowTxtStyle,
//             ),
//           );
//         }
//
//         return CustomTableTheme(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColor.dividerColor, width: 0.65),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: DataTable(
//                 columns: const [
//                   DataColumn(label: Text('Corporate ID')),
//                   DataColumn(label: Text('Transaction Date')),
//                   DataColumn(label: Text('Response Code')),
//                   DataColumn(label: Text('Response')),
//                   DataColumn(label: Text('Bank RRN')),
//                   DataColumn(label: Text('Bank Reference Number')),
//                   DataColumn(label: Text('Transaction ID')),
//                   DataColumn(label: Text('Bank')),
//                 ],
//                 rows: docIdResponse
//                     .asMap()
//                     .map((index, e) {
//                   Color rowColor =
//                   index.isEven ? Colors.white : AppColor.tableRowColor;
//
//                   return MapEntry(
//                     index,
//                     DataRow(
//                       color: MaterialStateProperty.all(rowColor),
//                       cells: [
//                         DataCell(Text(e.tRANREFNO ?? '')),
//                         DataCell(Text(e.tRADT?.split('T').isNotEmpty == true
//                             ? e.tRADT!.split('T')[0]
//                             : '')),
//                         DataCell(Text(e.aCTCODE ?? '')),
//                         DataCell(Text(e.rESPONSE ?? '')),
//                         DataCell(Text(e.bANKRRN ?? '')),
//                         DataCell(Text(e.bANKREFNUM ?? '')),
//                         DataCell(Text("${e.tRANSID ?? ''}")),
//                         DataCell(Text(e.bANK ?? '')),
//                       ],
//                     ),
//                   );
//                 })
//                     .values
//                     .toList(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
// class CorIdDataTable3 extends StatelessWidget {
//   const CorIdDataTable3({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PaymentStatusProvider>(
//       builder: (context, paymentStatusProvider, child) {
//         final docIdResponse = paymentStatusProvider.corIDdataModel3.response;
//
//         if (docIdResponse == null || docIdResponse.isEmpty) {
//           return Center(
//             child: Text(
//               "No data found",
//               style: _tableRowTxtStyle,
//             ),
//           );
//         }
//
//         return CustomTableTheme(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColor.dividerColor, width: 0.65),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: DataTable(
//                 columns: const [
//                   DataColumn(label: Text('UNIQUE_REF_NO')),
//                   DataColumn(label: Text('PAY_DATE')),
//                   DataColumn(label: Text('TRA_UTR_NO')),
//                   DataColumn(label: Text('CHQ_NO')),
//                   DataColumn(label: Text('STATUS')),
//                   DataColumn(label: Text('STATUS_DESC')),
//                   DataColumn(label: Text('BANK_REF_NO')),
//                   DataColumn(label: Text('AMOUNT')),
//                   DataColumn(label: Text('BENEFICIARY_ACC_NO')),
//                   DataColumn(label: Text('TRA_DATE')),
//                   DataColumn(label: Text('TRANSID')),
//                   DataColumn(label: Text('BATCH_NO')),
//                 ],
//                 rows: docIdResponse
//                     .asMap()
//                     .map((index, e) {
//                       Color rowColor =
//                           index.isEven ? Colors.white : AppColor.tableRowColor;
//
//                       return MapEntry(
//                         index,
//                         DataRow(
//                           color: MaterialStateProperty.all(rowColor),
//                           cells: [
//                             DataCell(Text(e.uNIQUEREFNO ?? '')),
//                             DataCell(Text(
//                                 e.pAYDATE?.split('T').isNotEmpty == true
//                                     ? e.pAYDATE!.split('T')[0]
//                                     : '')),
//                             DataCell(Text(e.tRAUTRNO ?? '')),
//                             DataCell(Text(e.cHQNO ?? '')),
//                             DataCell(Text(e.sTATUS ?? '')),
//                             DataCell(Text(e.sTATUSDESC ?? '')),
//                             DataCell(Text(e.bANKREFNO ?? '')),
//                             DataCell(Text(e.aMOUNT ?? '')),
//                             DataCell(Text(e.bENEFICIARYACCNO ?? '')),
//                             DataCell(Text(
//                                 e.tRADATE?.split('T').isNotEmpty == true
//                                     ? e.tRADATE!.split('T')[0]
//                                     : '')),
//                             DataCell(Text("${e.tRANSID ?? ''}")),
//                             DataCell(Text(e.bATCHNO ?? '')),
//                           ],
//                         ),
//                       );
//                     })
//                     .values
//                     .toList(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// const _tableRowTxtStyle = TextStyle(
//     fontFamily: 'poppinsRegular',
//     fontSize: 10,
//     color: AppColor.cardTitleSubColor);
