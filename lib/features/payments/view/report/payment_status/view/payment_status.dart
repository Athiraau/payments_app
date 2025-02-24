import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:payments_application/core/helpers/routes/app_route_name.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/payment_status_controller.dart';

class PaymentStatus extends StatefulWidget {
  const PaymentStatus({super.key});

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaymentStatusProvider>(context, listen: false)
          .chkRRNumStatus();
    });
  }

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
              title: 'Payment Status',
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
                child: Consumer<PaymentStatusProvider>(
                  builder: (context, paymentStatusProvider, child) {
                    paymentStatusProvider.setCurBranchName();
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
                                    text: paymentStatusProvider.branchName
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
                                      ? "${paymentStatusProvider.formattedDate}, ${paymentStatusProvider.formattedTime}"
                                      : "${paymentStatusProvider.formattedDate},\n${paymentStatusProvider.formattedTime}",
                                  fontSize: isTablet ? 12 : 10,
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
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: CustomText(
                                          text: 'Payment Transaction Status',
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
                                            height: 20,
                                          ),
                                          const CustomText(
                                            text:
                                                'Please select a search option:',
                                            fontSize: 14,
                                            fontFamily: 'poppinsRegular',
                                            color: AppColor.cardTitleSubColor,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          _customRadioTile(
                                            title: 'Document ID',
                                            value: '1',
                                            groupValue: paymentStatusProvider
                                                .selectedOption,
                                            onChanged: (value) {
                                              paymentStatusProvider
                                                  .updateSelectedOption(value!);
                                            },
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          _customRadioTile(
                                            title: 'Customer ID',
                                            value: '2',
                                            groupValue: paymentStatusProvider
                                                .selectedOption,
                                            onChanged: (value) {
                                              paymentStatusProvider
                                                  .updateSelectedOption(value!);
                                            },
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          paymentStatusProvider.showRRnum?_customRadioTile(
                                            title: 'RR Number',
                                            value: '3',
                                            groupValue: paymentStatusProvider
                                                .selectedOption,
                                            onChanged: (value) {
                                              paymentStatusProvider
                                                  .updateSelectedOption(value!);
                                            },
                                          ):const SizedBox.shrink(),
                                          const SizedBox(height: 15),
                                          CustomText(
                                            text:
                                                'Please enter ${paymentStatusProvider.curDocTitle}:',
                                            fontSize: 14,
                                            fontFamily: 'poppinsRegular',
                                            color: AppColor.cardTitleSubColor,
                                          ),
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            height: 40,
                                            child: CustomTextField(
                                              labelTxt:
                                                  'Enter ${paymentStatusProvider.curDocTitle}',
                                              hintTxt:
                                                  'Enter ${paymentStatusProvider.curDocTitle}',
                                              controller: _textController,
                                              keyboardType: TextInputType.text,
                                              labelTxtStyle: const TextStyle(
                                                  color: AppColor
                                                      .txtFieldItemColor),
                                              hintTxtStyle: const TextStyle(
                                                  color: AppColor
                                                      .txtFieldItemColor),
                                              onChanged: (value) {
                                                paymentStatusProvider
                                                    .validateUserId(
                                                        id: _textController
                                                            .text,
                                                        type:
                                                            paymentStatusProvider.curDocTitle);
                                              },
                                              obscureText: false,
                                            ),
                                          ),
                                          paymentStatusProvider
                                                  .validateId.isNotEmpty
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: CustomText(
                                                    text: paymentStatusProvider
                                                        .validateId,
                                                    fontSize: 10,
                                                    fontFamily:
                                                        'poppinsRegular',
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      )),
                                      SizedBox(
                                        width: size.width,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 30),
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
                                                btnColor: AppColor.drawerColor,
                                                borderRadious: 8,
                                                progress: paymentStatusProvider
                                                        .isLoading
                                                    ? const SizedBox(
                                                        width: 10,
                                                        height: 10,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ))
                                                    : null,
                                                width: isTablet
                                                    ? size.width * 0.20
                                                    : size.width * 0.30,
                                                height: 35,
                                                onPressed: () {
                                                  if (_textController
                                                      .text.isEmpty) {
                                                    paymentStatusProvider
                                                        .validateUserId(
                                                            id: _textController
                                                                .text,
                                                            type: paymentStatusProvider
                                                                .selectedOption);
                                                  } else {
                                                    paymentStatusProvider
                                                        .fetchPayStatusData(
                                                            context: context,
                                                            id: _textController
                                                                .text);
                                                  }
                                                },
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              CustomButton(
                                                text: 'Exit',
                                                txtColor: Colors.white,
                                                btnColor: paymentStatusProvider
                                                        .hoverBtn
                                                    ? AppColor.errorTxt
                                                    : AppColor.dividerColor,
                                                borderRadious: 8,
                                                fontSize: 16,
                                                width: isTablet
                                                    ? size.width * 0.20
                                                    : size.width * 0.30,
                                                height: 35,
                                                onHover: (isHovering) {
                                                  paymentStatusProvider
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
                                  )),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _customRadioTile({
  required final String title,
  required final String value,
  required final String groupValue,
  required final ValueChanged<String?> onChanged,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return AppColor.hdTxtColor;
          }
          return AppColor.cardTitleSubColor; // Default color
        }),
        activeColor: AppColor.hdTxtColor,
      ),
      SizedBox(
        width: 10,
      ),
      CustomText(
        text: title,
        fontSize: 12,
        fontFamily: 'poppinsRegular',
        color: AppColor.cardTitleColor,
      ),
    ],
  );
}
