import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payment_app/features/payments/view/payments/change_debit_advice_branch/controller/change_debit_advise_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../model/change_req_data_model.dart';

class ChangeDebitAdviseBranch extends StatelessWidget {
  const ChangeDebitAdviseBranch({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    return ChangeNotifierProvider(
      create: (context) =>
          ChangeDebitAdviseProvider()..setData(context: context),
      child: Consumer<ChangeDebitAdviseProvider>(
        builder: (context, provider, child) {
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
                    title: 'Change Debit Advise Branch',
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: size.width,
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      color: AppColor.drawerColor,
                                      Icons.arrow_back,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: isTablet
                                      ? size.width * 0.75
                                      : size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: AppColor.cardItem,
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
                                  child: Column(
                                    children: [
                                      Container(
                                        width: isTablet
                                            ? size.width * 0.75
                                            : size.width * 0.9,
                                        decoration: BoxDecoration(
                                          color: AppColor.drawerColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0)),
                                        ),
                                        height: 45,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text:
                                                  'Change Debit Advise Branch',
                                              fontSize: 14,
                                              fontFamily: 'poppinsSemiBold',
                                              color: AppColor.primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    height: 35,
                                                    width: size.width * 0.30,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        CustomText(
                                                          text: "Branch :",
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'poppinsRegular',
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                            width: 50)
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        provider.branchList
                                                                .isNotEmpty
                                                            ? Row(
                                                                children: [
                                                                  Container(
                                                                    width: size
                                                                            .width *
                                                                        0.25,
                                                                    height: 35,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              AppColor.dividerColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        DropdownButton2(
                                                                      dropdownSearchData:
                                                                          DropdownSearchData(
                                                                        searchController:
                                                                            provider.branchController,
                                                                        searchInnerWidgetHeight:
                                                                            50,
                                                                        searchInnerWidget:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8,
                                                                              horizontal: 8),
                                                                          child:
                                                                              TextFormField(
                                                                            expands:
                                                                                true,
                                                                            maxLines:
                                                                                null,
                                                                            controller:
                                                                                provider.branchController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                borderSide: const BorderSide(color: Colors.black),
                                                                              ),
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Search branch',
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      isExpanded:
                                                                          true,
                                                                      underline:
                                                                          const SizedBox(),
                                                                      value: provider.selectedBranchId !=
                                                                              -1
                                                                          ? provider
                                                                              .selectedBranch
                                                                          : null,
                                                                      hint:
                                                                          CustomText(
                                                                        text:
                                                                            '----------Select branch----------',
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      items: provider
                                                                          .branchList
                                                                          .map(
                                                                              (branch) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              branch.bRANCHNAME,
                                                                          child:
                                                                              CustomText(
                                                                            text:
                                                                                branch.bRANCHNAME ?? '',
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (value) {
                                                                        if (value !=
                                                                            null) {
                                                                          provider.setSelectedBranch(
                                                                              value: value,
                                                                              context: context);
                                                                          provider
                                                                              .fetchDocument(
                                                                            context:
                                                                                context,
                                                                            branchId:
                                                                                provider.selectedBranchId.toString(),
                                                                          );

                                                                          provider
                                                                              .fetchNewBranch(
                                                                            context:
                                                                                context,
                                                                            branchId:
                                                                                provider.selectedBranchId.toString(),
                                                                          );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Row(
                                                                children: [
                                                                  Container(
                                                                    height: 35,
                                                                    width: size
                                                                            .width *
                                                                        0.25,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              AppColor.dividerColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          CustomText(
                                                                        text:
                                                                            '----------Select branch----------',
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    height: 35,
                                                    width: size.width * 0.30,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        CustomText(
                                                          text: 'Document ID :',
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'poppinsRegular',
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                            width: 50)
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width:
                                                            size.width * 0.25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColor
                                                              .primaryColor,
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColor
                                                                  .dividerColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: DropdownButton2(
                                                          isExpanded: true,
                                                          dropdownStyleData:
                                                              DropdownStyleData(
                                                                  maxHeight:
                                                                      300,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  )),
                                                          underline:
                                                              const SizedBox(),
                                                          value: provider
                                                                  .selectedDocId!
                                                                  .isNotEmpty
                                                              ? provider
                                                                  .selectedDocId
                                                              : null,
                                                          hint:
                                                              const CustomText(
                                                            text:
                                                                '----------Select document----------',
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'poppinsRegular',
                                                            color: Colors.black,
                                                          ),
                                                          items: provider
                                                                  .docIdList
                                                                  .isEmpty
                                                              ? [
                                                                  DropdownMenuItem(
                                                                    value: null,
                                                                    child:
                                                                        CustomText(
                                                                      text:
                                                                          '----------Select document----------',
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'poppinsRegular',
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ]
                                                              : provider
                                                                  .docIdList
                                                                  .map((docId) {
                                                                  return DropdownMenuItem(
                                                                    value: docId
                                                                        .dOCINFO,
                                                                    child:
                                                                        CustomText(
                                                                      text: docId
                                                                              .dOCINFO
                                                                              ?.toString() ??
                                                                          '',
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'poppinsRegular',
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                          onChanged: (value) {
                                                            if (value != null) {
                                                              provider
                                                                  .setSelectedDocId(
                                                                      value:
                                                                          value);
                                                              final split =
                                                                  value.split(
                                                                      '-');

                                                              provider.fetchTableData(
                                                                  context:
                                                                      context,
                                                                  corId: split[
                                                                          1]
                                                                      .trim());
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            width: 1,
                                                            color: const Color(
                                                                0xFFCCC6C6)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      width: 750,
                                                      height: 250,
                                                      child: Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                          cardTheme: CardTheme(
                                                            elevation: 0,
                                                            margin:
                                                                EdgeInsets.zero,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                          ),
                                                          dividerTheme:
                                                              const DividerThemeData(
                                                            space: 0,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                        child:
                                                            PaginatedDataTable2(
                                                          headingRowHeight:
                                                              35.0,
                                                          dataRowHeight: 40.0,
                                                          horizontalMargin: 0,
                                                          columnSpacing: 0,
                                                          minWidth: size.width,
                                                          wrapInCard: false,
                                                          headingRowColor:
                                                              WidgetStateProperty
                                                                  .all(
                                                            const Color(
                                                                0xFF112D4E),
                                                          ),
                                                          headingTextStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13,
                                                          ),
                                                          dataTextStyle:
                                                              TextStyle(
                                                            color: Colors
                                                                .grey[800],
                                                            fontSize: 13,
                                                          ),
                                                          dividerThickness: 0.5,
                                                          rowsPerPage: provider
                                                              .rowsPerPage,
                                                          availableRowsPerPage: const [
                                                            10,
                                                            20,
                                                            50
                                                          ],
                                                          onRowsPerPageChanged:
                                                              (value) {
                                                            provider
                                                                .updateRowsPage(
                                                                    data:
                                                                        value!);
                                                          },
                                                          showFirstLastButtons:
                                                              true,
                                                          showCheckboxColumn:
                                                              false,
                                                          columns: [
                                                            DataColumn2(
                                                                label: Center(
                                                                  child: Text(
                                                                      'Branch',
                                                                      style:
                                                                          _tableRowHead),
                                                                ),
                                                                fixedWidth:
                                                                    150),
                                                            DataColumn2(
                                                                label: Center(
                                                                  child: Text(
                                                                      'Document ID',
                                                                      style:
                                                                          _tableRowHead),
                                                                ),
                                                                fixedWidth:
                                                                    150),
                                                            DataColumn2(
                                                              fixedWidth: 150,
                                                              label: Center(
                                                                child: Text(
                                                                    'Customer ID',
                                                                    style:
                                                                        _tableRowHead),
                                                              ),
                                                            ),
                                                            DataColumn2(
                                                              fixedWidth: 150,
                                                              label: Center(
                                                                child: Text(
                                                                    'Amount',
                                                                    style:
                                                                        _tableRowHead),
                                                              ),
                                                            ),
                                                            DataColumn2(
                                                              fixedWidth: 150,
                                                              label: Center(
                                                                child: Text(
                                                                    'Corporate ID',
                                                                    style:
                                                                        _tableRowHead),
                                                              ),
                                                            ),
                                                          ],
                                                          source: PostDataSource(
                                                              provider
                                                                  .tableDataList,
                                                              provider,
                                                              context),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    height: 35,
                                                    width: size.width * 0.30,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        CustomText(
                                                          text: 'New branch :',
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'poppinsRegular',
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                            width: 50)
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        provider.newBranchList
                                                                .isNotEmpty
                                                            ? Row(
                                                                children: [
                                                                  Container(
                                                                    height: 35,
                                                                    width: size
                                                                            .width *
                                                                        0.25,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              AppColor.dividerColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        DropdownButton2(
                                                                      isExpanded:
                                                                          true,
                                                                      dropdownStyleData: DropdownStyleData(
                                                                          maxHeight: 300,
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          )),
                                                                      underline:
                                                                          const SizedBox(),
                                                                      value: provider
                                                                              .selectedNewBranch!
                                                                              .isNotEmpty
                                                                          ? provider
                                                                              .selectedNewBranch
                                                                          : null,
                                                                      dropdownSearchData:
                                                                          DropdownSearchData(
                                                                        searchController:
                                                                            provider.branchController,
                                                                        searchInnerWidgetHeight:
                                                                            50,
                                                                        searchInnerWidget:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8,
                                                                              horizontal: 8),
                                                                          child:
                                                                              TextFormField(
                                                                            expands:
                                                                                true,
                                                                            maxLines:
                                                                                null,
                                                                            controller:
                                                                                provider.branchController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                borderSide: const BorderSide(color: Colors.black),
                                                                              ),
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Search branch',
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      hint:
                                                                          const CustomText(
                                                                        text:
                                                                            '----------Select new branch----------',
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      items: provider
                                                                          .newBranchList
                                                                          .map(
                                                                              (docId) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              docId.bRANCHOPTION,
                                                                          child:
                                                                              CustomText(
                                                                            text:
                                                                                docId.bRANCHOPTION?.toString() ?? '',
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (value) {
                                                                        provider.setSelectedNewBranch(
                                                                            value:
                                                                                value.toString().trim());
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Row(
                                                                children: [
                                                                  Container(
                                                                    height: 35,
                                                                    width: size
                                                                            .width *
                                                                        0.25,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              AppColor.dividerColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          CustomText(
                                                                        text:
                                                                            '----------Select new branch----------',
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 26),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                        text: 'Confirm',
                                                        txtColor: Colors.white,
                                                        btnColor: AppColor
                                                            .drawerColor,
                                                        borderRadious: 8,
                                                        progress: provider
                                                                .isLoading
                                                            ? const SizedBox(
                                                                width: 10,
                                                                height: 10,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                ))
                                                            : null,
                                                        width: isTablet
                                                            ? 120
                                                            : 100,
                                                        height: 35,
                                                        onPressed: () {
                                                          if (provider
                                                                  .selectedBranchId ==
                                                              -1) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .errorTxt,
                                                                content:
                                                                    CustomText(
                                                                  text:
                                                                      'please select branch',
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            );
                                                          } else if (provider
                                                              .selectedDocId!
                                                              .isEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .errorTxt,
                                                                content:
                                                                    CustomText(
                                                                  text:
                                                                      'please select document id',
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            );
                                                          } else if (provider
                                                              .selectedNewBranch!
                                                              .isEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .errorTxt,
                                                                content:
                                                                    CustomText(
                                                                  text:
                                                                      'please select new branch',
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            provider
                                                                .updateChangeDebitAdviseBranch(
                                                                    context:
                                                                        context);
                                                          }
                                                        }),
                                                    const SizedBox(width: 10),
                                                    CustomButton(
                                                      text: 'Exit',
                                                      txtColor: Colors.white,
                                                      btnColor: provider
                                                              .hoverBtn
                                                          ? AppColor.card3Title
                                                          : AppColor.errorTxt,
                                                      width:
                                                          isTablet ? 120 : 100,
                                                      height: 35,
                                                      borderRadious: 8,
                                                      onHover: (isHovering) {
                                                        provider.mouseHover();
                                                      },
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PostDataSource extends DataTableSource {
  final List<ChangeReqDataModel> data;
  final ChangeDebitAdviseProvider provider;
  final BuildContext context;

  PostDataSource(this.data, this.provider, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow2(
      cells: [
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.bRANCHID.toString(), style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.dOCID.toString(), style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.cUSTID.toString(), style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.aMOUNT.toString(), style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.cORPORATEID.toString(), style: _tableRowTxtStyle),
          ),
        ),
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
