import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_text.dart';
import '../controller/breadcrumbs_controller.dart';

class BreadCrumbs extends StatelessWidget {
  final String title;
  const BreadCrumbs({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 50,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 13,
                fontFamily: 'poppinsSemiBold',
                color: AppColor.hdTxtColor,
              ),
            ),
            Consumer<BreadCrumbsProvider>(
              builder: (context, breadcrumbsProvider, child) {
                var breadcrumbs = breadcrumbsProvider.breadcrumbs;
                return Expanded(
                  child: SizedBox(
                    height: 35,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: breadcrumbs.length + 1,
                        separatorBuilder: (context, index) => Icon(
                          Icons.chevron_right,
                          color: Colors.black54,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: AppColor.hdTxtColor,
                                  size: 23,
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  text: "Home",
                                  fontSize: 12,
                                  fontFamily: 'poppinsRegular',
                                  color: Colors.black,
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: CustomText(
                                text: breadcrumbs[index - 1],
                                fontSize: 12,
                                fontFamily: 'poppinsRegular',
                                color: Colors.black,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
