import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/cus_neft_controller.dart';
import '../model/cus_neft_model.dart';

class CusNEFTDetails extends StatefulWidget {
  const CusNEFTDetails({super.key});

  @override
  State<CusNEFTDetails> createState() => _CusNEFTDetailsState();
}

class _CusNEFTDetailsState extends State<CusNEFTDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    return ChangeNotifierProvider(
      create: (context) => CusNEFTDetailsProvider(),
      child: Consumer<CusNEFTDetailsProvider>(
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
                    title: 'Customer NEFT Details',
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
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => context.pop(),
                                            icon: const Icon(
                                              color: AppColor.drawerColor,
                                              Icons.arrow_back,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: isTablet
                                          ? size.width * 0.75
                                          : size.width * 0.9,
                                      decoration: BoxDecoration(
                                        color: AppColor.cardItem,
                                        border: Border.all(
                                            width: 1,
                                            color: AppColor.dividerColor),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8.0),
                                                      topRight:
                                                          Radius.circular(8.0)),
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
                                                  text: 'Customer NEFT Details',
                                                  fontSize: 14,
                                                  fontFamily: 'poppinsSemiBold',
                                                  color: AppColor.primaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Container(
                                              width: isTablet
                                                  ? size.width * 0.25
                                                  : size.width * 0.9,
                                              padding: const EdgeInsets.all(16),
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
                                              child: Column(
                                                children: [
                                                  CustomText(
                                                    text: 'Enter Customer ID:',
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'poppinsRegular',
                                                    color: AppColor
                                                        .cardTitleSubColor,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    height: 35,
                                                    child: CustomTextField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'^[a-zA-Z0-9-_]*$')),
                                                      ],
                                                      labelTxt:
                                                          'Enter Customer ID',
                                                      hintTxt:
                                                          'Enter Customer ID',
                                                      controller: provider
                                                          .textController,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter a value';
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                          TextInputType.text,
                                                      labelTxtStyle:
                                                          const TextStyle(
                                                              color: AppColor
                                                                  .txtFieldItemColor),
                                                      hintTxtStyle: const TextStyle(
                                                          color: AppColor
                                                              .txtFieldItemColor),
                                                      onChanged: (value) {
                                                        provider.validateUserId(
                                                          id: provider
                                                              .textController
                                                              .text,
                                                        );
                                                      },
                                                      obscureText: false,
                                                    ),
                                                  ),
                                                  if (provider
                                                      .validateId.isNotEmpty)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: CustomText(
                                                        text:
                                                            provider.validateId,
                                                        fontSize: 10,
                                                        fontFamily:
                                                            'poppinsRegular',
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomButton(
                                                        text: 'Generate',
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
                                                              .textController
                                                              .text
                                                              .isEmpty) {
                                                            final snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                  "Customer ID should not be empty"),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                            provider
                                                                .validateUserId(
                                                              id: provider
                                                                  .textController
                                                                  .text,
                                                            );
                                                          } else if (provider
                                                              .validateId
                                                              .isNotEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    provider
                                                                        .validateId),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              ),
                                                            );
                                                          } else {
                                                            provider.fetchCusNEFTdata(
                                                                context:
                                                                    context,
                                                                userId: provider
                                                                    .textController
                                                                    .text);
                                                          }
                                                        },
                                                      ),
                                                      const SizedBox(width: 10),
                                                      CustomButton(
                                                        text: 'Exit',
                                                        txtColor: Colors.white,
                                                        btnColor: provider
                                                                .hoverBtn
                                                            ? AppColor
                                                                .card3Title
                                                            : AppColor.errorTxt,
                                                        width: isTablet
                                                            ? 120
                                                            : 100,
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
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Container(
                                                height: 250,
                                                width: size.width * 0.60,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xFFCCC6C6)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    cardTheme: CardTheme(
                                                      elevation: 0,
                                                      margin: EdgeInsets.zero,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: PaginatedDataTable2(
                                                    headingRowHeight: 35.0,
                                                    dataRowHeight: 40.0,
                                                    horizontalMargin: 16,
                                                    columnSpacing: 16,
                                                    minWidth: size.width,
                                                    wrapInCard: false,
                                                    headingRowColor:
                                                        WidgetStateProperty.all(
                                                      const Color(0xFF112D4E),
                                                    ),
                                                    headingTextStyle:
                                                        const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                    ),
                                                    dataTextStyle: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 13,
                                                    ),
                                                    dividerThickness: 0.5,
                                                    rowsPerPage:
                                                        provider.rowsPerPage,
                                                    availableRowsPerPage: const [
                                                      10,
                                                      20,
                                                      50
                                                    ],
                                                    onRowsPerPageChanged:
                                                        (value) {
                                                      provider.updateRowsPage(
                                                          data: value!);
                                                    },
                                                    showFirstLastButtons: true,
                                                    showCheckboxColumn: false,
                                                    columns: [
                                                      DataColumn2(
                                                        label: Center(
                                                            child: Text(
                                                                'CUSTOMER_ID',
                                                                style:
                                                                    _tableRowHead)),
                                                        size: ColumnSize.S,
                                                      ),
                                                      DataColumn2(
                                                        label: Center(
                                                            child: Text(
                                                                'CUSTOMER NAME',
                                                                style:
                                                                    _tableRowHead)),
                                                        size: ColumnSize.S,
                                                      ),
                                                      DataColumn2(
                                                        label: Center(
                                                            child: Text(
                                                                'BENEFICIARY BANK',
                                                                style:
                                                                    _tableRowHead)),
                                                        size: ColumnSize.S,
                                                      ),
                                                      DataColumn2(
                                                        label: Center(
                                                            child: Text(
                                                                'BENEFICIARY ACCOUNT',
                                                                style:
                                                                    _tableRowHead)),
                                                        size: ColumnSize.S,
                                                      ),
                                                      DataColumn2(
                                                        label: Center(
                                                            child: Text(
                                                                'BENEFICIARY IFSC',
                                                                style:
                                                                    _tableRowHead)),
                                                        size: ColumnSize.S,
                                                      ),
                                                      DataColumn2(
                                                        label: Center(
                                                            child: Text(
                                                                'BENEFICIARY BRANCH',
                                                                style:
                                                                    _tableRowHead)),
                                                        size: ColumnSize.S,
                                                      ),
                                                      DataColumn2(
                                                        label: Center(
                                                            child: Text(
                                                                'VERIFY STATUS',
                                                                style:
                                                                    _tableRowHead)),
                                                        size: ColumnSize.S,
                                                      ),
                                                    ],
                                                    source: PostDataSource(
                                                        provider.cusNEFTList,
                                                        provider,
                                                        context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
  final List<CusNEFTModel> data;
  final CusNEFTDetailsProvider provider;
  final BuildContext context;

  PostDataSource(this.data, this.provider, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow2(
      cells: [
        DataCell(Center(
            child: InkWell(
                onTap: () {
                  if (item.cUSTID != null) {
                    provider.fetchCusNEFTidProof(
                        context: context, cusId: item.cUSTID.toString());
                  }
                },
                child: Text(item.cUSTID ?? '_',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'poppinsRegular',
                      fontSize: 12,
                      color: AppColor.cardTitleSubColor,
                    ))))),
        DataCell(Center(
            child: Text(item.cUSTNAME ?? '_', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANK ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bENEFICIARYACCOUNT ?? '_',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.iFSCCODE ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child:
                Text(item.bENEFICIARYBRANCH ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.vERIFYSTATUS ?? '_', style: _tableRowTxtStyle))),
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
