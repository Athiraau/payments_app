// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_payment_app/features/payments/view/report/payment_status/view/payment_status_report/view/seq_num/view/seq_num.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
//
//
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../../../../../core/utils/config/styles/colors.dart';
// import '../../../../../../../../core/utils/shared/component/widgets/custom_button.dart';
// import '../../../../../../../../core/utils/shared/component/widgets/custom_table_theme.dart';
// import '../../../../../../../../core/utils/shared/component/widgets/custom_text.dart';
// import '../../../../../../../../core/utils/shared/component/widgets/custom_textfield.dart';
// import '../../../../../../../../core/utils/shared/constant/assets_path.dart';
// import '../../../../../../../bread_crumbs/view/bread_crumbs.dart';
// import '../../../../../../controller/payments_controller.dart';
// import '../../../controller/payment_status_controller.dart';
// import '../../../model/pay_status_table_model.dart';
// import 'cop_id/view/cop_id.dart';
// import 'doc_id/view/doc_id.dart';
//
// class PaymentStatusReport extends StatefulWidget {
//   const PaymentStatusReport({super.key});
//
//   @override
//   State<PaymentStatusReport> createState() => _PaymentStatusReportState();
// }
//
// class _PaymentStatusReportState extends State<PaymentStatusReport> {
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final isTablet = size.width >= 900;
//     return Consumer<PaymentStatusProvider>(
//       builder: (context, paymentStatusProvider, child) {
//         paymentStatusProvider.setCurBranchName();
//         return Container(
//           width: size.width,
//           height: size.height,
//           padding: const EdgeInsets.all(8.0),
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(AssetsPath.appBackground),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const BreadCrumbs(
//                   title: 'Payment Status Report',
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                     child: Container(
//                   width: size.width,
//                   height: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColor.primaryColor,
//                     border: Border.all(width: 1, color: AppColor.dividerColor),
//                     borderRadius: BorderRadius.circular(8.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 width: size.width * 0.15,
//                                 child: IconButton(
//                                   onPressed: () {
//                                     context.pop();
//                                   },
//                                   icon: const Icon(
//                                     color: AppColor.drawerColor,
//                                     Icons.arrow_back,
//                                     size: 24,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Center(
//                                   child: CustomText(
//                                     text: paymentStatusProvider.branchName
//                                         .toUpperCase(),
//                                     fontSize: isTablet ? 16 : 12,
//                                     fontFamily: 'poppinsSemiBold',
//                                     color: AppColor.hdTxtColor,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 alignment: Alignment.centerRight,
//                                 width: size.width * 0.15,
//                                 child: CustomText(
//                                   text: isTablet
//                                       ? "${paymentStatusProvider.formattedDate}, ${paymentStatusProvider.formattedTime}"
//                                       : "${paymentStatusProvider.formattedDate},\n${paymentStatusProvider.formattedTime}",
//                                   fontSize: isTablet ? 12 : 10,
//                                   fontFamily: 'poppinsRegular',
//                                   color: AppColor.hdTxtColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                             child: ListView(
//                                 scrollDirection: Axis.vertical,
//                                 shrinkWrap: true,
//                                 children: [
//                               paymentStatusProvider.filteredItems.isNotEmpty
//                                   ? Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16, vertical: 10),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           CustomButton(
//                                             progress: paymentStatusProvider
//                                                     .loadExcelReport
//                                                 ? const SizedBox(
//                                                     width: 10,
//                                                     height: 10,
//                                                     child:
//                                                         CircularProgressIndicator(
//                                                       color: Colors.white,
//                                                     ))
//                                                 : null,
//                                             customWidget: SvgPicture.asset(
//                                               AssetsPath.excel,
//                                               width: 18,
//                                               height: 18,
//                                               color: Colors.white,
//                                             ),
//                                             text: 'Export to Excel',
//                                             txtColor: Colors.white,
//                                             btnColor: AppColor.excelBtn,
//                                             borderRadious: 8,
//                                             width: 143,
//                                             height: 38,
//                                             onPressed: () {
//                                               paymentStatusProvider
//                                                   .exportToExcel(context);
//                                             },
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           CustomButton(
//                                             customWidget: SvgPicture.asset(
//                                               AssetsPath.pdf,
//                                               width: 18,
//                                               height: 18,
//                                               color: Colors.white,
//                                             ),
//                                             text: 'Export to Pdf',
//                                             txtColor: AppColor.primaryColor,
//                                             btnColor: AppColor.pdfBtn,
//                                             borderRadious: 8,
//                                             width: 143,
//                                             height: 40,
//                                             onPressed: () {
//                                               paymentStatusProvider
//                                                   .exportToPdf(context);
//                                             },
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           CustomButton(
//                                             text: 'Exit',
//                                             txtColor: Colors.white,
//                                             btnColor:
//                                                 AppColor.drawerImgTileColor,
//                                             borderRadious: 8,
//                                             width: 143,
//                                             height: 38,
//                                             onPressed: () {
//                                               context.pop();
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : const SizedBox.shrink(),
//                               Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 17,
//                                   ),
//                                   SizedBox(
//                                     width: size.width * 0.35,
//                                     height: 38,
//                                     child: CustomTextField(
//                                       labelTxt: 'Search',
//                                       hintTxt: 'Enter text',
//                                       controller: searchController,
//                                       keyboardType: TextInputType.text,
//                                       labelTxtStyle: const TextStyle(
//                                           color: AppColor.txtFieldItemColor),
//                                       hintTxtStyle: const TextStyle(
//                                           color: AppColor.txtFieldItemColor),
//                                       onChanged: (value) {
//                                         context
//                                             .read<PaymentStatusProvider>()
//                                             .searchItems(value);
//                                       },
//                                       validator: (value) => null,
//                                       obscureText: false,
//                                       suffixIcon: IconButton(
//                                         icon: const Icon(Icons.search),
//                                         onPressed: () {},
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               paymentStatusProvider.isLoading
//                                   ? _buildShimmerList()
//                                   : paymentStatusProvider
//                                           .filteredItems.isNotEmpty
//                                       ? Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 15.0),
//                                           child: CustomMainTableTheme(
//                                             child: PaginatedDataTable(
//                                               headingRowHeight: 50,
//                                               dataRowHeight: 40,
//                                               header: null,
//                                               columns: const [
//                                                 DataColumn(
//                                                     label: Text('Module')),
//                                                 DataColumn(
//                                                     label: Text('Branch')),
//                                                 DataColumn(
//                                                     label: Text('BranchId')),
//                                                 DataColumn(
//                                                     label: Text('DocId')),
//                                                 DataColumn(
//                                                     label: Text('CustomerId')),
//                                                 DataColumn(
//                                                     label: Text('Amount')),
//                                                 DataColumn(
//                                                     label: Text('TraDate')),
//                                                 DataColumn(
//                                                     label: Text('SendDate')),
//                                                 DataColumn(
//                                                     label: Text('SendTransId')),
//                                                 DataColumn(
//                                                     label: Text('CorporateId')),
//                                                 DataColumn(
//                                                     label: Text('BatchNumber')),
//                                                 DataColumn(
//                                                     label: Text('BeneName')),
//                                                 DataColumn(
//                                                     label: Text('BeneAccNo')),
//                                                 DataColumn(
//                                                     label:
//                                                         Text('BeneIFSCCode')),
//                                                 DataColumn(
//                                                     label: Text('SeqNumber')),
//                                               ],
//                                               source: TableDataSource(
//                                                   paymentStatusProvider
//                                                       .filteredItems
//                                                       .cast<Response>(),
//                                                   context),
//                                               rowsPerPage: paymentStatusProvider
//                                                   .rowsPerPage,
//                                               availableRowsPerPage: [5, 10, 20],
//                                               onRowsPerPageChanged: (value) {
//                                                 paymentStatusProvider
//                                                     .updateRowsPage(
//                                                         data: int.parse(
//                                                             value.toString()));
//                                               },
//                                               showCheckboxColumn: false,
//                                             ),
//                                           ),
//                                         )
//                                       : Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 20),
//                                             child: CustomText(
//                                               text: isTablet
//                                                   ? "No data found"
//                                                   : "No data found",
//                                               fontSize: isTablet ? 12 : 10,
//                                               fontFamily: 'poppinsRegular',
//                                               color: AppColor.hdTxtColor,
//                                             ),
//                                           ),
//                                         ),
//                             ]))
//                       ]),
//                 ))
//               ]),
//         );
//       },
//     );
//   }
// }
//
// class TableDataSource extends DataTableSource {
//   final List<Response> data;
//   final BuildContext context;
//
//   TableDataSource(List<Response>? data, this.context) : data = data ?? [];
//
//   @override
//   DataRow? getRow(int index) {
//     if (index >= data.length) {
//       return const DataRow(cells: [
//         DataCell(Text(
//           'No data available',
//           style:
//               TextStyle(fontStyle: FontStyle.italic, color: AppColor.errorTxt),
//         )),
//       ]);
//     }
//
//     final row = data[index];
//     Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
//     final paymentStatusProvider =
//         Provider.of<PaymentStatusProvider>(context, listen: false);
//     return DataRow(
//       color: MaterialStateProperty.all(rowColor),
//       cells: [
//         DataCell(Text(row.mODDESCR ?? '')),
//         DataCell(Text(row.bRANCHNAME ?? '')),
//         DataCell(Text("${row.bRANCHID ?? ''}")),
//         DataCell(
//           InkWell(
//             splashColor: Colors.transparent,
//             focusColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () async {
//               final docId = row.dOCID ?? '';
//               paymentStatusProvider.fetchDocIdData1(
//                   context: context, docId: docId);
//               paymentStatusProvider.fetchDocIdData2(
//                   context: context, docId: docId);
//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     backgroundColor: AppColor.primaryColor,
//                     content: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.45,
//                       height: MediaQuery.of(context).size.height * 0.40,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Consumer<PaymentStatusProvider>(
//                           builder: (context, payStObj, child) {
//                             final docIdModel1 = payStObj.docIdModel1;
//                             final docIdModel2 = payStObj.docIdModel2;
//
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const CustomText(
//                                         text: "Transaction Details",
//                                         fontSize: 14,
//                                         fontFamily: 'poppinsSemiBold',
//                                         color: AppColor.appBarColor,
//                                       ),
//                                       CustomButton(
//                                         customWidget: SvgPicture.asset(
//                                           AssetsPath.excel,
//                                           width: 16,
//                                           height: 16,
//                                           color: Colors.white,
//                                         ),
//                                         text: 'Excel',
//                                         txtColor: Colors.white,
//                                         btnColor: AppColor.drawerImgTileColor,
//                                         borderRadious: 8,
//                                         width: 80,
//                                         height: 25,
//                                         onPressed: () {
//                                           paymentStatusProvider
//                                               .exportToExcelDocId1(context);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: (docIdModel1
//                                               .docId1response?.isNotEmpty ??
//                                           false)
//                                       ? const Center(child: DocIdDataTable1())
//                                       : const CustomText(
//                                           text: "No data found",
//                                           fontSize: 12,
//                                           fontFamily: 'poppinsRegular',
//                                           color: AppColor.cardTitleSubColor,
//                                         ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const CustomText(
//                                         text: "Neft Customer Details",
//                                         fontSize: 14,
//                                         fontFamily: 'poppinsSemiBold',
//                                         color: AppColor.appBarColor,
//                                       ),
//                                       CustomButton(
//                                         customWidget: SvgPicture.asset(
//                                           AssetsPath.excel,
//                                           width: 16,
//                                           height: 16,
//                                           color: Colors.white,
//                                         ),
//                                         text: 'Excel',
//                                         txtColor: Colors.white,
//                                         btnColor: AppColor.drawerImgTileColor,
//                                         borderRadious: 8,
//                                         width: 80,
//                                         height: 25,
//                                         onPressed: () {
//                                           paymentStatusProvider
//                                               .exportToExcelDocId2(context);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: (docIdModel2
//                                               .docId2response?.isNotEmpty ??
//                                           false)
//                                       ? const Center(child: DocIdDataTable2())
//                                       : const CustomText(
//                                           text: "No data found",
//                                           fontSize: 12,
//                                           fontFamily: 'poppinsRegular',
//                                           color: AppColor.cardTitleSubColor,
//                                         ),
//                                 ),
//                                 const SizedBox(height: 10),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     actions: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColor.drawerImgTileColor,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop(); // Close the dialog
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.all(5),
//                               child: Text(
//                                 'Close',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text(
//               row.dOCID ?? '',
//               style: _highLiteTxtStyle,
//             ),
//           ),
//         ),
//         DataCell(
//           InkWell(
//             onTap: () {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (row.cUSTID != null) {
//                   paymentStatusProvider.fetchCusIdImg(
//                       context: context, custId: "${row.cUSTID}");
//
//                   Future.microtask(() {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           backgroundColor: AppColor.primaryColor,
//                           content: SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.40,
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Consumer<PaymentStatusProvider>(
//                                     builder: (context, obj, child) {
//                                       if (obj.customerIDModel.response ==
//                                               null ||
//                                           obj.customerIDModel.response!
//                                               .isEmpty) {
//                                         return const Center(
//                                           child: Text(
//                                             "No data found",
//                                             style: _tableRowTxtStyle,
//                                           ),
//                                         );
//                                       }
//                                       var firstResponse =
//                                           obj.customerIDModel.response!.first;
//                                       if (firstResponse.iDPROOF != null &&
//                                           firstResponse.iDPROOF.toString() !=
//                                               "null") {
//                                         return Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 10),
//                                             child: obj.imgBytes != null
//                                                 ? Image.memory(
//                                                     obj.imgBytes!,
//                                                     height: 200,
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.35,
//                                                     fit: BoxFit.fill,
//                                                   )
//                                                 : Container(),
//                                           ),
//                                         );
//                                       } else {
//                                         return const Center(
//                                           child: Text(
//                                             "No ID proof available",
//                                             style: _tableRowTxtStyle,
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           actions: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         AppColor.drawerImgTileColor,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(
//                                       'Close',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   });
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Customer ID is not available.'),
//                     ),
//                   );
//                 }
//               });
//             },
//             child: Text(
//               row.cUSTID ?? '',
//               style: _highLiteTxtStyle,
//             ),
//           ),
//         ),
//         DataCell(Text("${row.aMOUNT ?? ''}")),
//         DataCell(Text(row.vALUEDATE?.split('T').isNotEmpty == true
//             ? row.vALUEDATE!.split('T')[0]
//             : '')),
//         DataCell(Text(row.sENDDATE?.split('T').isNotEmpty == true
//             ? row.sENDDATE!.split('T')[0]
//             : '')),
//         DataCell(Text(row.sENDTRANSID ?? '')),
//         DataCell(
//           InkWell(
//             onTap: () async {
//               final corId = row.cORPORATEID ?? '';
//               paymentStatusProvider.fetchCorIdData1(
//                 context: context,
//                 corId: corId ?? '',
//               );
//               paymentStatusProvider.fetchCorIdData2(
//                 context: context,
//                 corId: corId ?? '',
//               );
//               paymentStatusProvider.fetchCorIdData3(
//                 context: context,
//                 corId: corId ?? '',
//               );
//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     backgroundColor: AppColor.primaryColor,
//                     content: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.45,
//                       height: MediaQuery.of(context).size.height * 0.40,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Consumer<PaymentStatusProvider>(
//                           builder: (context, payStObj, child) {
//                             final corIDdataModel1 = payStObj.corIdDataModel1;
//                             final corIDdataModel2 = payStObj.corIDdataModel2;
//                             final corIDdataModel3 = payStObj.corIDdataModel3;
//
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const CustomText(
//                                         text: "IMPS Sending Details",
//                                         fontSize: 14,
//                                         fontFamily: 'poppinsSemiBold',
//                                         color: AppColor.appBarColor,
//                                       ),
//                                       CustomButton(
//                                         customWidget: SvgPicture.asset(
//                                           AssetsPath.excel,
//                                           width: 16,
//                                           height: 16,
//                                           color: Colors.white,
//                                         ),
//                                         text: 'Excel',
//                                         txtColor: Colors.white,
//                                         btnColor: AppColor.drawerImgTileColor,
//                                         borderRadious: 8,
//                                         width: 80,
//                                         height: 25,
//                                         onPressed: () {
//                                           paymentStatusProvider
//                                               .exportToExcelCorId1(context);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: (paymentStatusProvider
//                                           .corDataList1.isNotEmpty)
//                                       ? const Center(child: CorIdDataTable1())
//                                       : const CustomText(
//                                           text: "No data found",
//                                           fontSize: 12,
//                                           fontFamily: 'poppinsRegular',
//                                           color: AppColor.cardTitleSubColor,
//                                         ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const CustomText(
//                                         text: "Imps Response Details",
//                                         fontSize: 14,
//                                         fontFamily: 'poppinsSemiBold',
//                                         color: AppColor.appBarColor,
//                                       ),
//                                       CustomButton(
//                                         customWidget: SvgPicture.asset(
//                                           AssetsPath.excel,
//                                           width: 16,
//                                           height: 16,
//                                           color: Colors.white,
//                                         ),
//                                         text: 'Excel',
//                                         txtColor: Colors.white,
//                                         btnColor: AppColor.drawerImgTileColor,
//                                         borderRadious: 8,
//                                         width: 80,
//                                         height: 25,
//                                         onPressed: () {
//                                           paymentStatusProvider
//                                               .exportToExcelCorId2(context);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: (paymentStatusProvider
//                                           .corDataList2.isNotEmpty)
//                                       ? const Center(child: CorIdDataTable2())
//                                       : const CustomText(
//                                           text: "No data found",
//                                           fontSize: 12,
//                                           fontFamily: 'poppinsRegular',
//                                           color: AppColor.cardTitleSubColor,
//                                         ),
//                                 ),
//                                 const SizedBox(height: 10),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     actions: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColor.drawerImgTileColor,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop(); // Close the dialog
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.all(5),
//                               child: Text(
//                                 'Close',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text(
//               row.cORPORATEID ?? '',
//               style: _highLiteTxtStyle,
//             ),
//           ),
//         ),
//         DataCell(Text(row.bATCHNO ?? '')),
//         DataCell(Text(row.cUSTNAME ?? '')),
//         DataCell(Text(row.bENEFICIARYACCOUNT ?? '')),
//         DataCell(Text(row.iFSCCODE ?? '')),
//         DataCell(
//           InkWell(
//             onTap: () async {
//               final seqNo = row.sEQNO ?? '';
//
//               paymentStatusProvider.fetchSeqData1(
//                   context: context, seqNo: seqNo.toString());
//               paymentStatusProvider.fetchSeqData2(
//                   context: context, seqNo: seqNo.toString());
//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     backgroundColor: AppColor.primaryColor,
//                     content: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.45,
//                       height: MediaQuery.of(context).size.height * 0.40,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Consumer<PaymentStatusProvider>(
//                           builder: (context, payStObj, child) {
//                             final seqDataModel1 = payStObj.seqDataModel1;
//                             final seqDataModel2 = payStObj.seqDataModel2;
//
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const CustomText(
//                                         text: "IMPS Sending Details",
//                                         fontSize: 14,
//                                         fontFamily: 'poppinsSemiBold',
//                                         color: AppColor.appBarColor,
//                                       ),
//                                       CustomButton(
//                                         customWidget: SvgPicture.asset(
//                                           AssetsPath.excel,
//                                           width: 16,
//                                           height: 16,
//                                           color: Colors.white,
//                                         ),
//                                         text: 'Excel',
//                                         txtColor: Colors.white,
//                                         btnColor: AppColor.drawerImgTileColor,
//                                         borderRadious: 8,
//                                         width: 80,
//                                         height: 25,
//                                         onPressed: () {
//                                           paymentStatusProvider
//                                               .exportToExcelSeqId1(context);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: (seqDataModel1.response?.isNotEmpty ??
//                                           false)
//                                       ? const Center(child: SeqNoDataTable1())
//                                       : const CustomText(
//                                           text: "No data found",
//                                           fontSize: 12,
//                                           fontFamily: 'poppinsRegular',
//                                           color: AppColor.cardTitleSubColor,
//                                         ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const CustomText(
//                                         text: "IMPS Response details",
//                                         fontSize: 14,
//                                         fontFamily: 'poppinsSemiBold',
//                                         color: AppColor.appBarColor,
//                                       ),
//                                       CustomButton(
//                                         customWidget: SvgPicture.asset(
//                                           AssetsPath.excel,
//                                           width: 16,
//                                           height: 16,
//                                           color: Colors.white,
//                                         ),
//                                         text: 'Excel',
//                                         txtColor: Colors.white,
//                                         btnColor: AppColor.drawerImgTileColor,
//                                         borderRadious: 8,
//                                         width: 80,
//                                         height: 25,
//                                         onPressed: () {
//                                           paymentStatusProvider
//                                               .exportToExcelSeqId2(context);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: (seqDataModel2.response?.isNotEmpty ??
//                                           false)
//                                       ? const Center(child: SeqNoDataTable2())
//                                       : const CustomText(
//                                           text: "No data found",
//                                           fontSize: 12,
//                                           fontFamily: 'poppinsRegular',
//                                           color: AppColor.cardTitleSubColor,
//                                         ),
//                                 ),
//                                 const SizedBox(height: 10),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     actions: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColor.drawerImgTileColor,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop(); // Close the dialog
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.all(5),
//                               child: Text(
//                                 'Close',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text(
//               row.sEQNO ?? '',
//               style: _highLiteTxtStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   bool get isRowCountApproximate => false;
//
//   @override
//   int get rowCount => data.length;
//
//   @override
//   int get selectedRowCount => 0;
// }
//
// const _tableRowTxtStyle = TextStyle(
//     fontFamily: 'poppinsRegular',
//     fontSize: 10,
//     color: AppColor.cardTitleSubColor);
//
// const _headTxtStyle = TextStyle(
//   fontFamily: 'poppinsRegular',
//   fontSize: 10,
//   color: AppColor.primaryColor,
// );
// const _headTxtStyle2 = TextStyle(
//   fontFamily: 'poppinsRegular',
//   fontSize: 12,
//   color: AppColor.primaryColor,
// );
// const _highLiteTxtStyle = TextStyle(
//   shadows: [Shadow(color: AppColor.highLiteTxt, offset: Offset(0, -5))],
//   color: Colors.transparent,
//   decoration: TextDecoration.underline,
//   decorationColor: AppColor.dividerColor,
//   decorationThickness: 4,
//   decorationStyle: TextDecorationStyle.dashed,
// );
//
// Widget _buildShimmerList() {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       children: [
//         Shimmer.fromColors(
//           baseColor: Colors.grey.shade300,
//           highlightColor: Colors.grey.shade100,
//           child: Container(
//             height: 80,
//             color: Colors.white,
//             margin: const EdgeInsets.only(bottom: 16.0),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: 25,
//             itemBuilder: (context, index) {
//               return Shimmer.fromColors(
//                 baseColor: Colors.grey.shade300,
//                 highlightColor: Colors.grey.shade100,
//                 child: Container(
//                   height: 20,
//                   color: Colors.white,
//                   margin: const EdgeInsets.symmetric(vertical: 4),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }
