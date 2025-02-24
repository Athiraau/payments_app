import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/helpers/routes/app_route_name.dart';
import 'package:payments_application/core/helpers/routes/app_route_path.dart';
import 'package:payments_application/core/utils/shared/component/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../../../controller/imps_inquiry_controller.dart';



class ImpsInquiryReport extends StatelessWidget {
  const ImpsInquiryReport({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _textController = TextEditingController();
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
                                              text: impsInquiryProvider.formattedDate +
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
                                              width: 1,
                                              color: AppColor.dividerColor),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                              Colors.grey.withOpacity(0.5),
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
                                                  Icon(
                                                    Icons.sort,
                                                    size: 20,
                                                    color: AppColor
                                                        .cardTitleSubColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomText(
                                                    text: "Filter",
                                                    fontSize: isTablet ? 12 : 9,
                                                    fontFamily:
                                                    'poppinsRegular',
                                                    color: AppColor
                                                        .cardTitleSubColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: [
                                              SizedBox(
                                                width: size.width,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      for (String label in [
                                                        "Module",
                                                        "Payment Type",
                                                        "Payment Bank",
                                                        "Branch",
                                                        "Status"
                                                      ])
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: CustomText(
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
                                      ),
                                    ),
                                  ]))
                        ]
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
