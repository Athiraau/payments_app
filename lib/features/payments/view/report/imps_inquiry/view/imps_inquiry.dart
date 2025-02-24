import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/helpers/routes/app_route_name.dart';
import 'package:payments_application/core/helpers/routes/app_route_path.dart';
import 'package:payments_application/core/utils/shared/component/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/imps_inquiry_controller.dart';

class ImpsInquiry extends StatelessWidget {
  const ImpsInquiry({super.key});

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
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
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
                                width: isTablet
                                    ? size.width * 0.50
                                    : size.width * 0.90,
                                height: isTablet
                                    ? size.height * 0.50
                                    : size.height * 0.90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: CustomText(
                                        text: 'IMPS Inquiry',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'poppinsBold',
                                        color: AppColor.drawerColor,
                                      ),
                                    ),
                                    const Divider(
                                      color: AppColor.dividerColor,
                                    ),
                                    Expanded(
                                      child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),

                                          // const SizedBox(height: 20),
                                          CustomText(
                                            text: 'Enter Corporate ID/Loan No:',
                                            fontSize: 14,
                                            fontFamily: 'poppinsRegular',
                                            color: AppColor.cardTitleSubColor,
                                          ),
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            height: 40,
                                            child: CustomTextField(
                                              labelTxt:
                                                  'Enter Corporate ID/Loan No',
                                              hintTxt:
                                                  'Enter Corporate ID/Loan No',
                                              controller: _textController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter a value';
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              labelTxtStyle: const TextStyle(
                                                  color: AppColor
                                                      .txtFieldItemColor),
                                              hintTxtStyle: const TextStyle(
                                                  color: AppColor
                                                      .txtFieldItemColor),
                                              onChanged: (value) {
                                                impsInquiryProvider
                                                    .validateUserId(
                                                    id: _textController
                                                        .text,
                                                    type:
                                                    impsInquiryProvider.curDocTitle);
                                              },
                                              obscureText: false,
                                            ),
                                          ),
                                          impsInquiryProvider
                                              .validateId.isNotEmpty
                                              ? Padding(
                                            padding: const EdgeInsets
                                                .symmetric(vertical: 5),
                                            child: CustomText(
                                              text: impsInquiryProvider
                                                  .validateId,
                                              fontSize: 10,
                                              fontFamily:
                                              'poppinsRegular',
                                              color: Colors.red,
                                            ),
                                          )
                                              : const SizedBox.shrink(),
                                          SizedBox(
                                            width: size.width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15, top: 30),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomButton(
                                                      text: 'Generate',
                                                      txtColor: Colors.white,
                                                      btnColor:
                                                          AppColor.drawerColor,
                                                      borderRadious: 8,
                                                      progress: impsInquiryProvider
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
                                                          ? size.width * 0.20
                                                          : size.width * 0.30,
                                                      height: 35,
                                                      onPressed: () {
                                                        if (_textController
                                                            .text.isEmpty) {
                                                          impsInquiryProvider
                                                              .validateUserId(
                                                                  id: _textController
                                                                      .text,
                                                                  type: impsInquiryProvider
                                                                      .selectedOption);
                                                        } else {

                                                          impsInquiryProvider
                                                              .fetchimpxData(
                                                                  context:
                                                                      context,
                                                                  id: _textController
                                                                      .text);

                                                        }
                                                      }

                                                      ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomButton(
                                                    text: 'Exit',
                                                    txtColor: Colors.white,
                                                    btnColor:
                                                        impsInquiryProvider
                                                                .hoverBtn
                                                            ? AppColor.errorTxt
                                                            : AppColor
                                                                .dividerColor,
                                                    borderRadious: 8,
                                                    fontSize: 16,
                                                    width: isTablet
                                                        ? size.width * 0.20
                                                        : size.width * 0.30,
                                                    height: 35,
                                                    onHover: (isHovering) {
                                                      impsInquiryProvider
                                                          .mouseHover();
                                                    },
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
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
