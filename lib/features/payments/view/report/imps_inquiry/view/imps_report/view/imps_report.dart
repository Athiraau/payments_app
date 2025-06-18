import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../../../core/utils/shared/component/widgets/calender_theme.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_table_theme.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../../../../payment_status/view/payment_status_report/view/payment_status_report.dart';
import '../../../controller/imps_inquiry_controller.dart';
import '../../../model/imps_inquiry_model.dart';

class ImpsInquiryReport extends StatefulWidget {
  const ImpsInquiryReport({super.key});

  @override
  State<ImpsInquiryReport> createState() => _ImpsInquiryReportState();
}

class _ImpsInquiryReportState extends State<ImpsInquiryReport> {
  late ImpsInquiryProvider impsInquiryProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    impsInquiryProvider = Provider.of<ImpsInquiryProvider>(context);
  }

  @override
  void dispose() {
    impsInquiryProvider.clearFields();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
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
                  border: Border.all(width: 1, color: AppColor.dividerColor),
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
                      impsInquiryProvider.setCurBranchName();
                      return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: ListView(
                                    scrollDirection: Axis.vertical,
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
                                                text: impsInquiryProvider
                                                    .formattedDate +
                                                    " " +
                                                    impsInquiryProvider.formattedTime,
                                                fontSize: 12,
                                                fontFamily: 'poppinsRegular',
                                                color: AppColor.hdTxtColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 17.0),
                                        child: Container(
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            border: Border.all(
                                                width: 1, color: AppColor.dividerColor),
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
                                                    const Icon(
                                                      Icons.sort,
                                                      size: 20,
                                                      color: AppColor.cardTitleSubColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    CustomText(
                                                      text: "Filter",
                                                      fontSize: isTablet ? 12 : 9,
                                                      fontFamily: 'poppinsRegular',
                                                      color: AppColor.cardTitleSubColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              children: [
                                                SizedBox(
                                                  width: size.width,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                      child: CustomText(
                                                                        text: "Module",
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
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                      size.height *
                                                                          0.065,
                                                                      width: size.width,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        border: Border.all(
                                                                            color: AppColor
                                                                                .dividerColor,
                                                                            width: 1.0),
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            8),
                                                                      ),
                                                                      child:
                                                                      DropdownButtonHideUnderline(
                                                                        child:
                                                                        DropdownButton2(
                                                                          dropdownStyleData: const DropdownStyleData(
                                                                              decoration: BoxDecoration(
                                                                                  color: AppColor
                                                                                      .primaryColor),
                                                                              maxHeight:
                                                                              300),
                                                                          menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                              overlayColor:
                                                                              MaterialStatePropertyAll(AppColor.dividerColor)),
                                                                          hint:
                                                                          const CustomText(
                                                                            text:
                                                                            "Select module",
                                                                            fontFamily:
                                                                            "poppinsRegular",
                                                                            color: AppColor
                                                                                .backBtn,
                                                                            fontSize:
                                                                            12,
                                                                          ),
                                                                          dropdownSearchData:
                                                                          DropdownSearchData(
                                                                              searchController: impsInquiryProvider
                                                                                  .searchModule,
                                                                              searchInnerWidgetHeight:
                                                                              50,
                                                                              searchInnerWidget:
                                                                              Container(
                                                                                height:
                                                                                50,
                                                                                padding:
                                                                                const EdgeInsets.only(
                                                                                  top: 8,
                                                                                  bottom: 4,
                                                                                  right: 8,
                                                                                  left: 8,
                                                                                ),
                                                                                child:
                                                                                TextFormField(
                                                                                  expands: true,
                                                                                  maxLines: null,
                                                                                  controller: impsInquiryProvider.searchModule,
                                                                                  decoration: InputDecoration(
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      borderSide: const BorderSide(color: AppColor.dividerColor),
                                                                                    ),
                                                                                    isDense: true,
                                                                                    contentPadding: const EdgeInsets.symmetric(
                                                                                      horizontal: 10,
                                                                                      vertical: 8,
                                                                                    ),
                                                                                    hintText: 'Search module',
                                                                                    hintStyle: const TextStyle(
                                                                                      fontFamily: "poppinsRegular",
                                                                                      color: AppColor.dividerColor,
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                          isExpanded:
                                                                          true,
                                                                          items: impsInquiryProvider
                                                                              .modules
                                                                              .map<DropdownMenuItem<String>>(
                                                                                  (element) {
                                                                                return DropdownMenuItem<
                                                                                    String>(
                                                                                  value: element[
                                                                                  "name"], // Make sure this is unique for each item
                                                                                  child:
                                                                                  CustomText(
                                                                                    text:
                                                                                    "${element["name"]}",
                                                                                    fontFamily:
                                                                                    "poppinsRegular",
                                                                                    color: AppColor
                                                                                        .backBtn,
                                                                                    fontSize:
                                                                                    12,
                                                                                  ),
                                                                                );
                                                                              }).toList(),
                                                                          value: impsInquiryProvider
                                                                              .selectedModule
                                                                              .isNotEmpty
                                                                              ? impsInquiryProvider
                                                                              .selectedModule
                                                                              : null,
                                                                          onChanged:
                                                                              (value) {
                                                                            if (value !=
                                                                                null) {
                                                                              impsInquiryProvider
                                                                                  .selectedModule =
                                                                                  value;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: Align(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                        child:
                                                                        CustomText(
                                                                          text:
                                                                          "Payment type",
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
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                        size.height *
                                                                            0.065,
                                                                        width:
                                                                        size.width,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border: Border.all(
                                                                              color: AppColor
                                                                                  .dividerColor,
                                                                              width:
                                                                              1.0),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              8),
                                                                        ),
                                                                        child:
                                                                        DropdownButtonHideUnderline(
                                                                          child:
                                                                          DropdownButton2(
                                                                            dropdownStyleData: const DropdownStyleData(
                                                                                decoration: BoxDecoration(
                                                                                    color: AppColor
                                                                                        .primaryColor),
                                                                                maxHeight:
                                                                                300),
                                                                            menuItemStyleData:
                                                                            const MenuItemStyleData(
                                                                                overlayColor:
                                                                                MaterialStatePropertyAll(AppColor.dividerColor)),
                                                                            hint:
                                                                            const CustomText(
                                                                              text:
                                                                              "Select payment type",
                                                                              fontFamily:
                                                                              "poppinsRegular",
                                                                              color: AppColor
                                                                                  .backBtn,
                                                                              fontSize:
                                                                              12,
                                                                            ),
                                                                            dropdownSearchData: DropdownSearchData(
                                                                                searchController: impsInquiryProvider.searchPaymentType,
                                                                                searchInnerWidgetHeight: 50,
                                                                                searchInnerWidget: Container(
                                                                                  height:
                                                                                  50,
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                    top:
                                                                                    8,
                                                                                    bottom:
                                                                                    4,
                                                                                    right:
                                                                                    8,
                                                                                    left:
                                                                                    8,
                                                                                  ),
                                                                                  child:
                                                                                  TextFormField(
                                                                                    expands:
                                                                                    true,
                                                                                    maxLines:
                                                                                    null,
                                                                                    controller:
                                                                                    impsInquiryProvider.searchModule,
                                                                                    decoration:
                                                                                    InputDecoration(
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        borderSide: const BorderSide(color: AppColor.dividerColor),
                                                                                      ),
                                                                                      isDense: true,
                                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                                        horizontal: 10,
                                                                                        vertical: 8,
                                                                                      ),
                                                                                      hintText: 'Search payment type',
                                                                                      hintStyle: const TextStyle(
                                                                                        fontFamily: "poppinsRegular",
                                                                                        color: AppColor.dividerColor,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                            isExpanded:
                                                                            true,
                                                                            items: impsInquiryProvider
                                                                                .paymentType
                                                                                .map<DropdownMenuItem<String>>(
                                                                                    (element) {
                                                                                  return DropdownMenuItem<
                                                                                      String>(
                                                                                    value: element[
                                                                                    "name"], // Make sure this is unique for each item
                                                                                    child:
                                                                                    CustomText(
                                                                                      text:
                                                                                      "${element["name"]}",
                                                                                      fontFamily:
                                                                                      "poppinsRegular",
                                                                                      color:
                                                                                      AppColor.backBtn,
                                                                                      fontSize:
                                                                                      12,
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                            value: impsInquiryProvider
                                                                                .selectedPaymentType
                                                                                .isNotEmpty
                                                                                ? impsInquiryProvider
                                                                                .selectedPaymentType
                                                                                : null,
                                                                            onChanged:
                                                                                (value) {
                                                                              if (value !=
                                                                                  null) {
                                                                                impsInquiryProvider.selectedPaymentType =
                                                                                    value;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: Align(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                        child:
                                                                        CustomText(
                                                                          text:
                                                                          "Payment bank",
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
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                        size.height *
                                                                            0.065,
                                                                        width:
                                                                        size.width,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border: Border.all(
                                                                              color: AppColor
                                                                                  .dividerColor,
                                                                              width:
                                                                              1.0),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              8),
                                                                        ),
                                                                        child:
                                                                        DropdownButtonHideUnderline(
                                                                          child:
                                                                          DropdownButton2(
                                                                            dropdownStyleData: const DropdownStyleData(
                                                                                decoration: BoxDecoration(
                                                                                    color: AppColor
                                                                                        .primaryColor),
                                                                                maxHeight:
                                                                                300),
                                                                            menuItemStyleData:
                                                                            const MenuItemStyleData(
                                                                                overlayColor:
                                                                                MaterialStatePropertyAll(AppColor.dividerColor)),
                                                                            hint:
                                                                            const CustomText(
                                                                              text:
                                                                              "Select payment bank",
                                                                              fontFamily:
                                                                              "poppinsRegular",
                                                                              color: AppColor
                                                                                  .backBtn,
                                                                              fontSize:
                                                                              12,
                                                                            ),
                                                                            dropdownSearchData: DropdownSearchData(
                                                                                searchController: impsInquiryProvider.searchPaymentBank,
                                                                                searchInnerWidgetHeight: 50,
                                                                                searchInnerWidget: Container(
                                                                                  height:
                                                                                  50,
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                    top:
                                                                                    8,
                                                                                    bottom:
                                                                                    4,
                                                                                    right:
                                                                                    8,
                                                                                    left:
                                                                                    8,
                                                                                  ),
                                                                                  child:
                                                                                  TextFormField(
                                                                                    expands:
                                                                                    true,
                                                                                    maxLines:
                                                                                    null,
                                                                                    controller:
                                                                                    impsInquiryProvider.searchPaymentBank,
                                                                                    decoration:
                                                                                    InputDecoration(
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        borderSide: const BorderSide(color: AppColor.dividerColor),
                                                                                      ),
                                                                                      isDense: true,
                                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                                        horizontal: 10,
                                                                                        vertical: 8,
                                                                                      ),
                                                                                      hintText: 'Search payment bank',
                                                                                      hintStyle: const TextStyle(
                                                                                        fontFamily: "poppinsRegular",
                                                                                        color: AppColor.dividerColor,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                            isExpanded:
                                                                            true,
                                                                            items: impsInquiryProvider
                                                                                .paymentBank
                                                                                .map<DropdownMenuItem<String>>(
                                                                                    (element) {
                                                                                  return DropdownMenuItem<
                                                                                      String>(
                                                                                    value: element[
                                                                                    "name"], // Make sure this is unique for each item
                                                                                    child:
                                                                                    CustomText(
                                                                                      text:
                                                                                      "${element["name"]}",
                                                                                      fontFamily:
                                                                                      "poppinsRegular",
                                                                                      color:
                                                                                      AppColor.backBtn,
                                                                                      fontSize:
                                                                                      12,
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                            value: impsInquiryProvider
                                                                                .selectedPaymentBank
                                                                                .isNotEmpty
                                                                                ? impsInquiryProvider
                                                                                .selectedPaymentBank
                                                                                : null,
                                                                            onChanged:
                                                                                (value) {
                                                                              if (value !=
                                                                                  null) {
                                                                                impsInquiryProvider.selectedPaymentBank =
                                                                                    value;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: Align(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                        child:
                                                                        CustomText(
                                                                          text:
                                                                          "Branch",
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
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                        size.height *
                                                                            0.065,
                                                                        width:
                                                                        size.width,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border: Border.all(
                                                                              color: AppColor
                                                                                  .dividerColor,
                                                                              width:
                                                                              1.0),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              8),
                                                                        ),
                                                                        child:
                                                                        DropdownButtonHideUnderline(
                                                                          child:
                                                                          DropdownButton2(
                                                                            dropdownStyleData: const DropdownStyleData(
                                                                                decoration: BoxDecoration(
                                                                                    color: AppColor
                                                                                        .primaryColor),
                                                                                maxHeight:
                                                                                300),
                                                                            menuItemStyleData:
                                                                            const MenuItemStyleData(
                                                                                overlayColor:
                                                                                MaterialStatePropertyAll(AppColor.dividerColor)),
                                                                            hint:
                                                                            const CustomText(
                                                                              text:
                                                                              "Select branch",
                                                                              fontFamily:
                                                                              "poppinsRegular",
                                                                              color: AppColor
                                                                                  .backBtn,
                                                                              fontSize:
                                                                              12,
                                                                            ),
                                                                            dropdownSearchData: DropdownSearchData(
                                                                                searchController: impsInquiryProvider.searchBranch,
                                                                                searchInnerWidgetHeight: 50,
                                                                                searchInnerWidget: Container(
                                                                                  height:
                                                                                  50,
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                    top:
                                                                                    8,
                                                                                    bottom:
                                                                                    4,
                                                                                    right:
                                                                                    8,
                                                                                    left:
                                                                                    8,
                                                                                  ),
                                                                                  child:
                                                                                  TextFormField(
                                                                                    expands:
                                                                                    true,
                                                                                    maxLines:
                                                                                    null,
                                                                                    controller:
                                                                                    impsInquiryProvider.searchBranch,
                                                                                    decoration:
                                                                                    InputDecoration(
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        borderSide: const BorderSide(color: AppColor.dividerColor),
                                                                                      ),
                                                                                      isDense: true,
                                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                                        horizontal: 10,
                                                                                        vertical: 8,
                                                                                      ),
                                                                                      hintText: 'Search module',
                                                                                      hintStyle: const TextStyle(
                                                                                        fontFamily: "poppinsRegular",
                                                                                        color: AppColor.dividerColor,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                            isExpanded:
                                                                            true,
                                                                            items: impsInquiryProvider
                                                                                .branch
                                                                                .map<DropdownMenuItem<String>>(
                                                                                    (element) {
                                                                                  return DropdownMenuItem<
                                                                                      String>(
                                                                                    value: element[
                                                                                    "name"], // Make sure this is unique for each item
                                                                                    child:
                                                                                    CustomText(
                                                                                      text:
                                                                                      "${element["name"]}",
                                                                                      fontFamily:
                                                                                      "poppinsRegular",
                                                                                      color:
                                                                                      AppColor.backBtn,
                                                                                      fontSize:
                                                                                      12,
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                            value: impsInquiryProvider
                                                                                .selectedBranch
                                                                                .isNotEmpty
                                                                                ? impsInquiryProvider
                                                                                .selectedBranch
                                                                                : null,
                                                                            onChanged:
                                                                                (value) {
                                                                              if (value !=
                                                                                  null) {
                                                                                impsInquiryProvider.selectedBranch =
                                                                                    value;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: Align(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                        child:
                                                                        CustomText(
                                                                          text:
                                                                          "Status",
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
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                        size.height *
                                                                            0.065,
                                                                        width:
                                                                        size.width,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border: Border.all(
                                                                              color: AppColor
                                                                                  .dividerColor,
                                                                              width:
                                                                              1.0),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              8),
                                                                        ),
                                                                        child:
                                                                        DropdownButtonHideUnderline(
                                                                          child:
                                                                          DropdownButton2(
                                                                            dropdownStyleData: const DropdownStyleData(
                                                                                decoration: BoxDecoration(
                                                                                    color: AppColor
                                                                                        .primaryColor),
                                                                                maxHeight:
                                                                                300),
                                                                            menuItemStyleData:
                                                                            const MenuItemStyleData(
                                                                                overlayColor:
                                                                                MaterialStatePropertyAll(AppColor.dividerColor)),
                                                                            hint:
                                                                            const CustomText(
                                                                              text:
                                                                              "Select status",
                                                                              fontFamily:
                                                                              "poppinsRegular",
                                                                              color: AppColor
                                                                                  .backBtn,
                                                                              fontSize:
                                                                              12,
                                                                            ),
                                                                            dropdownSearchData: DropdownSearchData(
                                                                                searchController: impsInquiryProvider.searchStatus,
                                                                                searchInnerWidgetHeight: 50,
                                                                                searchInnerWidget: Container(
                                                                                  height:
                                                                                  50,
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                    top:
                                                                                    8,
                                                                                    bottom:
                                                                                    4,
                                                                                    right:
                                                                                    8,
                                                                                    left:
                                                                                    8,
                                                                                  ),
                                                                                  child:
                                                                                  TextFormField(
                                                                                    expands:
                                                                                    true,
                                                                                    maxLines:
                                                                                    null,
                                                                                    controller:
                                                                                    impsInquiryProvider.searchStatus,
                                                                                    decoration:
                                                                                    InputDecoration(
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        borderSide: const BorderSide(color: AppColor.dividerColor),
                                                                                      ),
                                                                                      isDense: true,
                                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                                        horizontal: 10,
                                                                                        vertical: 8,
                                                                                      ),
                                                                                      hintText: 'Search status',
                                                                                      hintStyle: const TextStyle(
                                                                                        fontFamily: "poppinsRegular",
                                                                                        color: AppColor.dividerColor,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                            isExpanded:
                                                                            true,
                                                                            items: impsInquiryProvider
                                                                                .status
                                                                                .map<DropdownMenuItem<String>>(
                                                                                    (element) {
                                                                                  return DropdownMenuItem<
                                                                                      String>(
                                                                                    value: element[
                                                                                    "name"], // Make sure this is unique for each item
                                                                                    child:
                                                                                    CustomText(
                                                                                      text:
                                                                                      "${element["name"]}",
                                                                                      fontFamily:
                                                                                      "poppinsRegular",
                                                                                      color:
                                                                                      AppColor.backBtn,
                                                                                      fontSize:
                                                                                      12,
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                            value: impsInquiryProvider
                                                                                .selectedStatus
                                                                                .isNotEmpty
                                                                                ? impsInquiryProvider
                                                                                .selectedStatus
                                                                                : null,
                                                                            onChanged:
                                                                                (value) {
                                                                              if (value !=
                                                                                  null) {
                                                                                impsInquiryProvider.selectedStatus =
                                                                                    value;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                      child: CustomText(
                                                                        text:
                                                                        "From date",
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
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                      size.height *
                                                                          0.065,
                                                                      width: size.width,
                                                                      child:
                                                                      CustomTextField(
                                                                        prefixIcon:
                                                                        IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            DateTime?
                                                                            pickedDate =
                                                                            await showDatePicker(
                                                                              context:
                                                                              context,
                                                                              initialDate:
                                                                              DateTime
                                                                                  .now(),
                                                                              firstDate:
                                                                              DateTime(
                                                                                  1900),
                                                                              lastDate:
                                                                              DateTime
                                                                                  .now(),
                                                                              builder: (BuildContext
                                                                              context,
                                                                                  Widget?
                                                                                  child) {
                                                                                return CustomCalendarTheme.customCalendarTheme(
                                                                                    context,
                                                                                    child ??
                                                                                        Container());
                                                                              },
                                                                            );

                                                                            if (pickedDate !=
                                                                                null) {
                                                                              impsInquiryProvider
                                                                                  .setFromDate(
                                                                                  pickedDate);
                                                                              String
                                                                              formattedDate =
                                                                              DateFormat('yyyy-MM-dd')
                                                                                  .format(pickedDate);
                                                                              impsInquiryProvider
                                                                                  .fromDateController
                                                                                  .text = formattedDate;
                                                                            }
                                                                          },
                                                                          icon: const Icon(
                                                                              Icons
                                                                                  .calendar_today,
                                                                              color: AppColor
                                                                                  .drawerColor,
                                                                              size: 20),
                                                                        ),
                                                                        readOnly: true,
                                                                        labelTxt:
                                                                        "Select from date",
                                                                        hintTxt:
                                                                        "Select from date",
                                                                        controller:
                                                                        impsInquiryProvider
                                                                            .fromDateController,
                                                                        keyboardType:
                                                                        TextInputType
                                                                            .datetime,
                                                                        labelTxtStyle: const TextStyle(
                                                                            color: AppColor
                                                                                .cardTitleSubColor,
                                                                            fontFamily:
                                                                            'poppinsRegular',
                                                                            fontSize:
                                                                            12),
                                                                        hintTxtStyle: const TextStyle(
                                                                            color: AppColor
                                                                                .cardTitleSubColor,
                                                                            fontFamily:
                                                                            'poppinsRegular',
                                                                            fontSize:
                                                                            12),
                                                                        onChanged:
                                                                            (value) {},
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                      child: CustomText(
                                                                        text: "To date",
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
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                      size.height *
                                                                          0.065,
                                                                      width: size.width,
                                                                      child:
                                                                      CustomTextField(
                                                                        prefixIcon:
                                                                        IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            DateTime?
                                                                            pickedDate =
                                                                            await showDatePicker(
                                                                              context:
                                                                              context,
                                                                              initialDate:
                                                                              DateTime
                                                                                  .now(),
                                                                              firstDate:
                                                                              DateTime(
                                                                                  1900),
                                                                              lastDate:
                                                                              DateTime
                                                                                  .now(),
                                                                              builder: (BuildContext
                                                                              context,
                                                                                  Widget?
                                                                                  child) {
                                                                                return CustomCalendarTheme.customCalendarTheme(
                                                                                    context,
                                                                                    child ??
                                                                                        Container());
                                                                              },
                                                                            );

                                                                            if (pickedDate !=
                                                                                null) {
                                                                              impsInquiryProvider
                                                                                  .setToDate(
                                                                                  pickedDate);
                                                                              String
                                                                              formattedDate =
                                                                              DateFormat('yyyy-MM-dd')
                                                                                  .format(pickedDate);
                                                                              impsInquiryProvider
                                                                                  .toDateController
                                                                                  .text = formattedDate;
                                                                            }
                                                                          },
                                                                          icon: const Icon(
                                                                              Icons
                                                                                  .calendar_today,
                                                                              color: AppColor
                                                                                  .drawerColor,
                                                                              size: 20),
                                                                        ),
                                                                        readOnly: true,
                                                                        labelTxt:
                                                                        "Select to date",
                                                                        hintTxt:
                                                                        "Select to date",
                                                                        controller:
                                                                        impsInquiryProvider
                                                                            .toDateController,
                                                                        keyboardType:
                                                                        TextInputType
                                                                            .datetime,
                                                                        labelTxtStyle: const TextStyle(
                                                                            color: AppColor
                                                                                .cardTitleSubColor,
                                                                            fontFamily:
                                                                            'poppinsRegular',
                                                                            fontSize:
                                                                            12),
                                                                        hintTxtStyle: const TextStyle(
                                                                            color: AppColor
                                                                                .cardTitleSubColor,
                                                                            fontFamily:
                                                                            'poppinsRegular',
                                                                            fontSize:
                                                                            12),
                                                                        onChanged:
                                                                            (value) {},
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const Expanded(
                                                                flex: 4,
                                                                child: SizedBox()),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0,
                                                                    horizontal:
                                                                    4.0),
                                                                child: CustomButton(
                                                                  onPressed: () {
                                                                    if (impsInquiryProvider
                                                                        .selectedModule
                                                                        .isEmpty) {
                                                                      CustomAlertDialog
                                                                          .showCustomAlertDialog(
                                                                        context:
                                                                        context,
                                                                        title: 'Failed',
                                                                        message:
                                                                        'Please select module',
                                                                        cancelText:
                                                                        'Ok',
                                                                        onCancelPressed:
                                                                            () {
                                                                          context.pop();
                                                                        },
                                                                      );
                                                                    } else if (impsInquiryProvider
                                                                        .selectedPaymentType
                                                                        .isEmpty) {
                                                                      CustomAlertDialog
                                                                          .showCustomAlertDialog(
                                                                        context:
                                                                        context,
                                                                        title: 'Failed',
                                                                        message:
                                                                        'Please select payment type',
                                                                        cancelText:
                                                                        'Ok',
                                                                        onCancelPressed:
                                                                            () {
                                                                          context.pop();
                                                                        },
                                                                      );
                                                                    } else if (impsInquiryProvider
                                                                        .selectedPaymentBank
                                                                        .isEmpty) {
                                                                      CustomAlertDialog
                                                                          .showCustomAlertDialog(
                                                                        context:
                                                                        context,
                                                                        title: 'Failed',
                                                                        message:
                                                                        'Please select payment bank',
                                                                        cancelText:
                                                                        'Ok',
                                                                        onCancelPressed:
                                                                            () {
                                                                          context.pop();
                                                                        },
                                                                      );
                                                                    } else if (impsInquiryProvider
                                                                        .selectedBranch
                                                                        .isEmpty) {
                                                                      CustomAlertDialog
                                                                          .showCustomAlertDialog(
                                                                        context:
                                                                        context,
                                                                        title: 'Failed',
                                                                        message:
                                                                        'Please select branch',
                                                                        cancelText:
                                                                        'Ok',
                                                                        onCancelPressed:
                                                                            () {
                                                                          context.pop();
                                                                        },
                                                                      );
                                                                    } else if (impsInquiryProvider
                                                                        .selectedStatus
                                                                        .isEmpty) {
                                                                      CustomAlertDialog
                                                                          .showCustomAlertDialog(
                                                                        context:
                                                                        context,
                                                                        title: 'Failed',
                                                                        message:
                                                                        'Please select status',
                                                                        cancelText:
                                                                        'Ok',
                                                                        onCancelPressed:
                                                                            () {
                                                                          context.pop();
                                                                        },
                                                                      );
                                                                    } else if (impsInquiryProvider
                                                                        .fromDateController
                                                                        .text
                                                                        .isEmpty) {
                                                                      CustomAlertDialog
                                                                          .showCustomAlertDialog(
                                                                        context:
                                                                        context,
                                                                        title: 'Failed',
                                                                        message:
                                                                        'Please select from date',
                                                                        cancelText:
                                                                        'Ok',
                                                                        onCancelPressed:
                                                                            () {
                                                                          context.pop();
                                                                        },
                                                                      );
                                                                    } else if (impsInquiryProvider
                                                                        .toDateController
                                                                        .text
                                                                        .isEmpty) {
                                                                      CustomAlertDialog
                                                                          .showCustomAlertDialog(
                                                                        context:
                                                                        context,
                                                                        title: 'Failed',
                                                                        message:
                                                                        'Please select to date',
                                                                        cancelText:
                                                                        'Ok',
                                                                        onCancelPressed:
                                                                            () {
                                                                          context.pop();
                                                                        },
                                                                      );
                                                                    } else {}
                                                                  },
                                                                  width:
                                                                  double.infinity,
                                                                  height: 40,
                                                                  text: "Generate",
                                                                  txtColor: AppColor
                                                                      .primaryColor,
                                                                  btnColor: AppColor
                                                                      .drawerColor,
                                                                  borderRadious: 8.0,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 17,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.35,
                                            height: 38,
                                            child: CustomTextField(
                                              labelTxt: 'Search',
                                              hintTxt: 'Enter text',
                                              controller:
                                              impsInquiryProvider.searchController,
                                              keyboardType: TextInputType.text,
                                              labelTxtStyle: const TextStyle(
                                                  color: AppColor.txtFieldItemColor),
                                              hintTxtStyle: const TextStyle(
                                                  color: AppColor.txtFieldItemColor),
                                              onChanged: (value) {
                                                context
                                                    .read<ImpsInquiryProvider>()
                                                    .searchItems(value);
                                              },
                                              validator: (value) => null,
                                              obscureText: false,
                                              suffixIcon: IconButton(
                                                icon: const Icon(Icons.search),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      impsInquiryProvider.filteredItems.isNotEmpty
                                          ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
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
                                                    color: Colors.white,
                                                  ))
                                                  : null,
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
                                              onPressed: () {
                                                impsInquiryProvider
                                                    .exportToExcel(context);
                                              },
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
                                              btnColor:
                                              AppColor.drawerImgTileColor,
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
                                      const SizedBox(height: 10),
                                      impsInquiryProvider.isLoading
                                          ? _buildShimmerList()
                                          : impsInquiryProvider.filteredItems.isNotEmpty
                                          ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: CustomMainTableTheme(
                                          child: PaginatedDataTable(
                                            headingRowHeight: 50,
                                            dataRowHeight: 40,
                                            header: null,
                                            columns: const [
                                              DataColumn(
                                                  label: Text('Module')),
                                              DataColumn(
                                                  label: Text('Branch')),
                                              DataColumn(
                                                  label: Text('BranchId')),
                                              DataColumn(
                                                  label: Text('DocId')),
                                              DataColumn(
                                                  label: Text('CustomerId')),
                                              DataColumn(
                                                  label: Text('Amount')),
                                              DataColumn(
                                                  label: Text('TraDate')),
                                              DataColumn(
                                                  label: Text('SendDate')),
                                              DataColumn(
                                                  label: Text('SendTransId')),
                                              DataColumn(
                                                  label: Text('CorporateId')),
                                              DataColumn(
                                                  label: Text('BatchNumber')),
                                              DataColumn(
                                                  label: Text('BeneName')),
                                              DataColumn(
                                                  label: Text('BeneAccNo')),
                                              DataColumn(
                                                  label:
                                                  Text('BeneIFSCCode')),
                                              DataColumn(
                                                  label: Text('SeqNumber')),
                                            ],
                                            source: TableDataSource(
                                                impsInquiryProvider
                                                    .filteredItems
                                                    .cast<ImpsInquiryModel>(),
                                                context),
                                            rowsPerPage: impsInquiryProvider
                                                .rowsPerPage,
                                            availableRowsPerPage: const [
                                              5,
                                              10,
                                              20
                                            ],
                                            onRowsPerPageChanged: (value) {
                                              impsInquiryProvider
                                                  .updateRowsPage(
                                                  data: int.parse(
                                                      value.toString()));
                                            },
                                            showCheckboxColumn: false,
                                          ),
                                        ),
                                      )
                                          : Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: CustomText(
                                            text: isTablet
                                                ? "No data found"
                                                : "No data found",
                                            fontSize: isTablet ? 12 : 10,
                                            fontFamily: 'poppinsRegular',
                                            color: AppColor.hdTxtColor,
                                          ),
                                        ),
                                      ),
                                    ]))
                          ]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableDataSource extends DataTableSource {
  final List<ImpsInquiryModel> data;
  final BuildContext context;

  TableDataSource(List<ImpsInquiryModel>? data, this.context)
      : data = data ?? [];

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
        DataCell(CustomText(text: row.mODDESCR ?? '')),
        DataCell(CustomText(
          text: row.branchName ?? '',
        )),
        DataCell(CustomText(
          text: row.branchId ?? '',
        )),
        DataCell(CustomText(
          text: row.docId ?? '',
        )),
        DataCell(CustomText(
          text: row.customerId ?? '',
        )),
        DataCell(CustomText(
          text: row.amount ?? '',
        )),
        DataCell(CustomText(
          text: row.valueDate ?? '',
        )),
        DataCell(CustomText(
          text: row.sendDate ?? '',
        )),
        DataCell(CustomText(
          text: row.sendTransactionId ?? '',
        )),
        DataCell(CustomText(
          text: row.coOperateId ?? '',
        )),
        DataCell(CustomText(
          text: row.batchNumber ?? '',
        )),
        DataCell(CustomText(
          text: row.customerName ?? '',
        )),
        DataCell(CustomText(
          text: row.beneficiaryAccount ?? '',
        )),
        DataCell(CustomText(
          text: row.iFSCCode ?? '',
        )),
        DataCell(CustomText(
          text: row.sEQNumber ?? '',
        )),
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
    fontSize: 10,
    color: AppColor.cardTitleSubColor);

const _headTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 10,
  color: AppColor.primaryColor,
);
const _headTxtStyle2 = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
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
