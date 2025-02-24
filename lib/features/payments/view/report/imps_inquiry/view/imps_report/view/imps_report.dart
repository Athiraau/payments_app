import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:payments_application/core/helpers/routes/app_route_name.dart';
import 'package:payments_application/core/helpers/routes/app_route_path.dart';
import 'package:payments_application/core/utils/shared/component/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../../../controller/imps_inquiry_controller.dart';
import '../../../model/demo_mode_remove.dart';
import '../../../model/imps_table_mode.dart';

class ImpsInquiryReport extends StatefulWidget {
  const ImpsInquiryReport({super.key});

  @override
  State<ImpsInquiryReport> createState() => _ImpsInquiryReportState();
}

class _ImpsInquiryReportState extends State<ImpsInquiryReport> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void dispose() {
    // Don't forget to dispose the controllers when the widget is destroyed
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _textController = TextEditingController();
    final isTablet = size.width >= 900;
    return Consumer<ImpsInquiryProvider>(
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
                  title: 'IMPS Inquiry',
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
                      child: Consumer<ImpsInquiryProvider>(
                        builder: (context, impsInquiryProvider, child) {
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
                                          text: impsInquiryProvider.branchName
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
                                            ? "${impsInquiryProvider.formattedDate}, ${impsInquiryProvider.formattedTime}"
                                            : "${impsInquiryProvider.formattedDate},\n${impsInquiryProvider.formattedTime}",
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
                                    impsInquiryProvider
                                            .impsTableModels.items!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 17.0),
                                            child: Container(
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppColor.dividerColor),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        dividerColor:
                                                            Colors.transparent),
                                                child: ExpansionTile(
                                                  title: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.sort,
                                                          size: 20,
                                                          color: AppColor
                                                              .cardTitleSubColor,
                                                        ),
                                                        SizedBox(width: 10),
                                                        CustomText(
                                                          text: "Filter",
                                                          fontSize:
                                                              isTablet ? 12 : 9,
                                                          fontFamily:
                                                              'poppinsRegular',
                                                          color: AppColor
                                                              .cardTitleSubColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          for (String label in [
                                                            "Module",
                                                            "Payment Type",
                                                            "Payment Bank",
                                                            "Branch",
                                                            "Status"
                                                          ])
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // Label at the top
                                                                  CustomText(
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
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  // Dropdown below the label with border
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColor.dividerColor, // Border color
                                                                          width:
                                                                              1.0, // Border width
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4.0), // Rounded corners
                                                                      ),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              8.0), // Inner padding
                                                                      child: DropdownButton<
                                                                          String>(
                                                                        isExpanded:
                                                                            true,
                                                                        dropdownColor:
                                                                            Colors.white, // Dropdown background color
                                                                        value: impsInquiryProvider
                                                                            .dropdownValues[label], // Current value
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          setState(
                                                                              () {
                                                                            impsInquiryProvider.dropdownValues[label] =
                                                                                newValue!;
                                                                          });
                                                                        },
                                                                        items: impsInquiryProvider
                                                                            .dropdownOptions[
                                                                                label]!
                                                                            .map<DropdownMenuItem<String>>((String
                                                                                value) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                Text(
                                                                              value,
                                                                              style: TextStyle(
                                                                                color: Colors.black, // Text color
                                                                                fontSize: isTablet ? 12 : 9,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black, // Selected item text color
                                                                        ),
                                                                        underline:
                                                                            SizedBox(), // Removes the default underline
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(height: 10),
                                                    // To Date Picker
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // From Date
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomText(
                                                                  text:
                                                                      "From Date",
                                                                  fontSize:
                                                                      isTablet
                                                                          ? 12
                                                                          : 9,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: AppColor
                                                                      .cardTitleSubColor,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .dividerColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                  child:
                                                                      TextFormField(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),

                                                                    controller:
                                                                        fromDateController, // You'll need to define this controller
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "Select From Date",
                                                                      border: InputBorder
                                                                          .none,
                                                                      suffixIcon:
                                                                          Icon(Icons
                                                                              .calendar_today),
                                                                    ),
                                                                    readOnly:
                                                                        true,
                                                                    onTap:
                                                                        () async {
                                                                      DateTime?
                                                                          pickedDate =
                                                                          await showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime.now(),
                                                                        firstDate:
                                                                            DateTime(2000),
                                                                        lastDate:
                                                                            DateTime(2101),
                                                                      );
                                                                      if (pickedDate !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          fromDateController.text =
                                                                              DateFormat('dd-MMM-yyyy').format(pickedDate);
                                                                        });
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          SizedBox(
                                                              width:
                                                                  10), // Space between From Date and To Date

                                                          // To Date
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomText(
                                                                  text:
                                                                      "To Date",
                                                                  fontSize:
                                                                      isTablet
                                                                          ? 12
                                                                          : 9,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: AppColor
                                                                      .cardTitleSubColor,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .dividerColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                  child:
                                                                      TextFormField(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    controller:
                                                                        toDateController, // You'll need to define this controller
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black, // Change color based on whether date is selected
                                                                      ),
                                                                      hintText:
                                                                          "Select To Date",
                                                                      border: InputBorder
                                                                          .none,
                                                                      suffixIcon:
                                                                          Icon(Icons
                                                                              .calendar_today),
                                                                    ),
                                                                    readOnly:
                                                                        true,
                                                                    onTap:
                                                                        () async {
                                                                      DateTime?
                                                                          pickedDate =
                                                                          await showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime.now(),
                                                                        firstDate:
                                                                            DateTime(2000),
                                                                        lastDate:
                                                                            DateTime(2101),
                                                                      );
                                                                      if (pickedDate !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          toDateController.text =
                                                                              DateFormat('dd-MMM-yyyy').format(pickedDate);
                                                                        });
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            5), // Space after the row
// Generate Button
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: CustomButton(
                                                        customWidget: null,
                                                        text: 'Generate',
                                                        txtColor: AppColor
                                                            .primaryColor,
                                                        btnColor: AppColor
                                                            .drawerImgTileColor,
                                                        borderRadious: 8,
                                                        width: 143,
                                                        height: 40,
                                                        onPressed: () {},
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    if (impsInquiryProvider
                                            .impsTableModels.items !=
                                        null)
                                      impsInquiryProvider
                                              .impsTableModels.items!.isNotEmpty
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
                                                    progress: impsInquiryProvider
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
                                                      impsInquiryProvider
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
                                                      impsInquiryProvider
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
                                    impsInquiryProvider.isLoading
                                        ? _buildShimmerList()
                                        : impsInquiryProvider.impsTableModels
                                                .items!.isNotEmpty
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
                                                        color: Colors.grey,
                                                        // Use bodyLarge instead of bodyText2
                                                      ),
                                                    ),
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
                                                          impsInquiryProvider
                                                              .impsTableModels
                                                              .items!
                                                              .cast<
                                                                  ImpsTableItem>(),
                                                          context),
                                                      rowsPerPage:
                                                          impsInquiryProvider
                                                              .rowsPerPage,
                                                      availableRowsPerPage: [
                                                        5,
                                                        10,
                                                        20
                                                      ],
                                                      onRowsPerPageChanged:
                                                          (value) {
                                                        impsInquiryProvider
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
  final List<ImpsTableItem> data;
  final BuildContext context;

  TableDataSource(List<ImpsTableItem>? data, this.context) : data = data ?? [];

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
        DataCell(Text(
          row.dOCID ?? '',
        )),
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

const _tableRowTxtStyle = TextStyle(
    fontFamily: 'poppinsRegular',
    fontSize: 10,
    color: AppColor.cardTitleSubColor);

const _headTxtStyle = TextStyle(
  fontFamily: 'poppinsSemiBold',
  fontSize: 13,
  color: AppColor.primaryColor,
);

const _highLiteTxtStyle = TextStyle(
  shadows: [Shadow(color: AppColor.highLiteTxt, offset: Offset(0, -5))],
  color: Colors.transparent,
  decoration: TextDecoration.underline,
  decorationColor: AppColor.dividerColor,
  decorationThickness: 4,
  decorationStyle: TextDecorationStyle.dashed,
);
