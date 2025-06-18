import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/component/widgets/item_card_widget.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/payments_controller.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => PaymentsProvider()..setTabIndex(0),
      child: Consumer<PaymentsProvider>(
        builder: (context, paymentsProvider, child) {
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Bread crumbs
                  const BreadCrumbs(title: 'Payments'),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ///Search bar
                                  SizedBox(
                                    width: size.width * 0.50,
                                    height: 40,
                                    child: CustomTextField(
                                      labelTxt: 'Search',
                                      hintTxt: 'Enter text',
                                      controller:
                                          paymentsProvider.searchController,
                                      keyboardType: TextInputType.text,
                                      labelTxtStyle: const TextStyle(
                                        color: AppColor.txtFieldItemColor,
                                      ),
                                      hintTxtStyle: const TextStyle(
                                        color: AppColor.txtFieldItemColor,
                                      ),
                                      onChanged: (value) {
                                        paymentsProvider.searchItems(value);
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
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  border: Border.all(
                                      width: 0.8, color: AppColor.tabBarColor),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                height: 50,
                                padding: const EdgeInsets.all(5),
                                child: TabBar(
                                  onTap: (index) {
                                    paymentsProvider.setTabIndex(index);
                                  },
                                  indicator: BoxDecoration(
                                    color: AppColor.drawerColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorColor: Colors.black,
                                  labelStyle: const TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  unselectedLabelStyle: const TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: AppColor.txtColorTab,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  dividerColor: Colors.transparent,
                                  tabs: const [
                                    Tab(text: "Payments"),
                                    Tab(text: "Reports"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: PaymentTabItem(),
                                ),
                              ),
                            ],
                          ),
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

///Tab bar items

class PaymentTabItem extends StatelessWidget {
  const PaymentTabItem({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<PaymentsProvider>(
      builder: (context, paymentProvider, child) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   paymentProvider.setTabIndex(0);
        // });
        final isMobile = size.width < 600;
        final isTablet = size.width >= 600 && size.width < 1024;
        final crossAxisCount = isMobile ? 1 : (isTablet ? 3 : 4);

        if (paymentProvider.isLoading) {
          return isMobile
              ? shimmerListView(itemCount: 6)
              : shimmerGridView(crossAxisCount: crossAxisCount, itemCount: 6);
        }

        if (paymentProvider.filteredItems.isEmpty) {
          return const Center(
            child: CustomText(
              text: "No items found",
              color: AppColor.drawerColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        return isMobile
            ? buildListView(paymentProvider.filteredItems)
            : buildGridView(paymentProvider.filteredItems, crossAxisCount);
      },
    );
  }
}

Widget shimmerListView({required int itemCount}) {
  return ListView.builder(
    itemCount: itemCount,
    itemBuilder: (context, index) => const Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: ShimmerWidget(height: 100, width: double.infinity),
    ),
  );
}

Widget shimmerGridView({required int crossAxisCount, required int itemCount}) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
    ),
    itemCount: itemCount,
    itemBuilder: (context, index) =>
        const ShimmerWidget(height: 100, width: double.infinity),
  );
}

Widget buildListView(List<Map<String, dynamic>> items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return SizedBox(
        width: double.infinity,
        height: 70,
        child: Consumer<PaymentsProvider>(
          builder: (context, paymentStatusProvider, child) {
            paymentStatusProvider.curIndex = index;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MouseRegion(
                opaque: false,
                cursor: MouseCursor.defer,
                onEnter: (_) => paymentStatusProvider.onEnter(index),
                onExit: (_) => paymentStatusProvider.onExit(),
                onHover: (_) {
                  paymentStatusProvider.selectedIndex = index;
                },
                child: Transform.scale(
                  scale:
                      paymentStatusProvider.selectedIndex == index ? 1.0 : 0.96,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: paymentStatusProvider.curIndex ==
                                paymentStatusProvider.selectedIndex
                            ? AppColor.cardTitleColor
                            : AppColor.dividerColor,
                        width: 1,
                      ),
                    ),
                    child: BuildCardItem(
                      item: item,
                      loadingStatus: paymentStatusProvider.isLoadingStatus,
                      onTap: () {
                        if (item['route'] == RoutesPath.re_initiate) {
                          context.goNamed(
                            RoutesName.reInitiate,
                            queryParameters: {
                              "userId": "1001",
                              "userName": "Raihan",
                            },
                          );
                        } else if (item['route'] == RoutesPath.paymentStatus) {
                          paymentStatusProvider.payStatusAccess(
                              context: context);

                          // context.go(item['route'] as String);
                        } else {
                          context.go(item['route'] as String);
                        }
                      },
                      curIndex: paymentStatusProvider.curIndex,
                      selectedIndex: paymentStatusProvider.loadingIndex,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget buildGridView(List<Map<String, dynamic>> items, int crossAxisCount) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Consumer<PaymentsProvider>(
        builder: (context, paymentStatusProvider, child) {
          paymentStatusProvider.curIndex = index;
          return MouseRegion(
            opaque: false,
            cursor: MouseCursor.defer,
            onEnter: (_) => paymentStatusProvider.onEnter(index),
            onExit: (_) => paymentStatusProvider.onExit(),
            onHover: (_) {
              paymentStatusProvider.selectedIndex = index;
            },
            child: Transform.scale(
              scale: paymentStatusProvider.selectedIndex == index ? 1.0 : 0.96,
              child: Animate(
                effects: [
                  FadeEffect(duration: 100.ms, curve: Curves.easeOut),
                  const ScaleEffect(
                      begin: Offset(0.8, 0.8), curve: Curves.easeIn)
                ],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: paymentStatusProvider.curIndex ==
                                paymentStatusProvider.selectedIndex
                            ? AppColor.cardTitleColor
                            : AppColor.dividerColor,
                        width: 1,
                      ),
                    ),
                    child: BuildGridItem(
                      item: item,
                      loadingStatus: paymentStatusProvider.isLoadingStatus,
                      onTap: () {
                        paymentStatusProvider.loadingIndex = index;
                        if (item['route'] == RoutesPath.re_initiate) {
                          context.goNamed(
                            RoutesName.reInitiate,
                            queryParameters: {
                              "userId": "1001",
                              "userName": "Raihan",
                            },
                          );
                        } else if (item['route'] ==
                            RoutesPath.changeDebitAdviseBranch) {
                          paymentStatusProvider.changeDebitAdviseAccess(
                              context: context);
                        } else if (item['route'] == RoutesPath.paymentStatus) {
                          paymentStatusProvider.payStatusAccess(
                              context: context);
                        } else if (item['route'] == RoutesPath.neftDeatils) {
                          paymentStatusProvider.chkCusNEFTDetAccess(
                              context: context);
                        } else {
                          context.go(item['route'] as String);
                        }
                      },
                      curIndex: paymentStatusProvider.curIndex,
                      selectedIndex: paymentStatusProvider.loadingIndex,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
