import 'package:flutter/material.dart';
import 'package:payments_application/features/drawer/view/drawer_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/config/styles/colors.dart';
import '../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../drawer/controller/drawer_controller.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;

    final isTablet = size.width >= 900;
    final appBarHeight = size.height * 0.073;

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      body: Row(
        children: [
          if (isTablet)
            Consumer<SliderProvider>(
              builder: (context, sliderController, child) {
                final drawerWidth = sliderController.isDrawerExpanded
                    ? size.width * 0.17
                    : size.width * 0.05;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: drawerWidth,
                  child: const DrawerWidget(),
                );
              },
            ),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.appbarColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColor.dividerColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  height: appBarHeight,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      if (!isTablet)
                        IconButton(
                          icon: const Icon(Icons.menu,color: AppColor.appBarColor,),
                          onPressed: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      if (isTablet)
                        Consumer<SliderProvider>(
                          builder: (context, sliderController, child) {
                            return IconButton(
                              icon: Icon(sliderController.isDrawerExpanded
                                  ? Icons.menu_open
                                  : Icons.menu,color: AppColor.appBarColor,),
                              onPressed: sliderController.toggleDrawerExpansion,
                            );
                          },
                        ),
                      const SizedBox(width: 8),
                      CustomText(
                        text:  "Payments Application",
                        fontSize: 18,
                        fontFamily: 'poppinsSemiBold',
                        color: AppColor.appBarColor,
                      ),
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
