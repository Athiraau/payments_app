import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../controller/drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sliderController = Provider.of<SliderProvider>(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;

    return Container(
      color: AppColor.drawerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.drawerImgTileColor,
              border: Border(
                bottom: BorderSide(
                  color: AppColor.dividerColor,
                  width: 1.0,
                ),
              ),
            ),
            height: size.height * 0.073,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/app_logo.png"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sliderController.items.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final item = sliderController.items[index];
                sliderController.chkIsSelected(title: item['title'].toString());

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildDrawerOption(
                    icon: item['logo'].toString(),
                    text: item['title'].toString(),
                    isSelected: sliderController.isSelected,
                    onTap: () {
                      sliderController.selectedItem = item['title']!;
                      context.go(item['route']!);
                      if (!isTablet) {
                        Navigator.of(context).pop();
                      }
                    },
                    isExpanded: sliderController.isDrawerExpanded,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerOption({
    required String icon,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isExpanded,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.27)
              : Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(6.0),
        ),
        height: 45,
        child: isExpanded
            ? Row(
                children: [
                  const SizedBox(width: 12),
                  SvgPicture.asset(
                    icon,
                    width: 22,
                    height: 22,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: text,
                            color: Colors.white,
                            fontFamily: 'poppinsRegular',
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                        ),
                        SvgPicture.asset(
                          AssetsPath.arrowBack,
                          width: 22,
                          height: 22,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: SvgPicture.asset(
                  icon,
                  width: 16,
                  height: 16,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
