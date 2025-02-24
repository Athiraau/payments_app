import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/helpers/encryption/app_encryption_helper.dart';
import 'package:payments_application/features/payments/view/report/payment_status/controller/payment_status_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/component/widgets/item_card_widget.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../bank_reconcilation/view/bank_reconcilation.dart';
import '../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/payments_controller.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaymentsProvider>(context, listen: false).setTabIndex(0);
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final paymentProvider = Provider.of<PaymentsProvider>(context);
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BreadCrumbs(title: 'Payments'),
            const SizedBox(height: 10),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.50,
                              height: 40,
                              child: CustomTextField(
                                labelTxt: 'Search',
                                hintTxt: 'Enter text',
                                controller: searchController,
                                keyboardType: TextInputType.text,
                                labelTxtStyle: const TextStyle(
                                    color: AppColor.txtFieldItemColor),
                                hintTxtStyle: const TextStyle(
                                    color: AppColor.txtFieldItemColor),
                                onChanged: (value) {
                                  context
                                      .read<PaymentsProvider>()
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
                              context
                                  .read<PaymentsProvider>()
                                  .setTabIndex(index);
                            },
                            indicator: BoxDecoration(
                                color: AppColor.drawerColor,
                                borderRadius: BorderRadius.circular(12)),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Colors.black,
                            labelStyle: TextStyle(
                              fontFamily: 'poppinsRegular',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            unselectedLabelStyle: TextStyle(
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TabBarView(
                              children: [
                                PaymentTabItem(),
                                ReportTabItem(),
                              ],
                            ),
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
  }
}

class PaymentTabItem extends StatelessWidget {
  const PaymentTabItem({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final paymentProvider = Provider.of<PaymentsProvider>(context);
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
  }

  Widget shimmerListView({required int itemCount}) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ShimmerWidget(height: 100, width: double.infinity),
      ),
    );
  }

  Widget shimmerGridView(
      {required int crossAxisCount, required int itemCount}) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) =>
          ShimmerWidget(height: 100, width: double.infinity),
    );
  }

  Widget buildListView(
    List<Map<String, dynamic>> items,
  ) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return SizedBox(
          width: double.infinity,
          height: 100,
          child: GestureDetector(
            onTap: () {
              if (item['route'] == RoutesPath.re_initiate) {
                context.goNamed(
                  RoutesName.reInitiate,
                  queryParams: {
                    "userId": "1001",
                    "userName": "Raihan",
                  },
                );
              } else if (item['route'] == RoutesPath.paymentStatus) {
                final paymentStatusProvider =
                    Provider.of<PaymentsProvider>(context, listen: false);
                paymentStatusProvider.chkAuthPayStatus(context: context);
              } else if (item['route'] == RoutesPath.impsInquiry) {
                final paymentStatusProvider =
                    Provider.of<PaymentsProvider>(context, listen: false);
                paymentStatusProvider.chkImpsStatus(context: context);
              } else {
                context.go(item['route'] as String);
              }
            },
            child:Consumer<PaymentsProvider>(
            builder: (context, paymentStatusProvider, child) {
              final isLoading =
                  paymentStatusProvider.currentLoadingRoute == item['route'];
            return  BuildCardItem(
                item: item,
              loadingStatus : isLoading,


            );

            },
            )

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
        childAspectRatio: 2.5,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            if (item['route'] == RoutesPath.re_initiate) {
              final encryptData = AppEncryptionHelper();
              final encryptedUserId = encryptData.encryptData(
                data: "1001",
                baseKey: EncryptionValue.keyAsString,
                ivKey: EncryptionValue.ivAsString,
              );

              final encryptedUserName = encryptData.encryptData(
                data: "Vineeth",
                baseKey: EncryptionValue.keyAsString,
                ivKey: EncryptionValue.ivAsString,
              );

              context.goNamed(
                RoutesName.reInitiate,
                queryParams: {
                  "userId": "1001",
                  "userName": "Raihan",
                },
              );
            } else if (item['route'] == RoutesPath.paymentStatus) {
              final paymentStatusProvider =
                  Provider.of<PaymentsProvider>(context, listen: false);
              paymentStatusProvider.chkAuthPayStatus(context: context);
            } else if (item['route'] == RoutesPath.impsInquiry) {
              final paymentStatusProvider =
                  Provider.of<PaymentsProvider>(context, listen: false);
              paymentStatusProvider.chkImpsStatus(context: context);

            } else {
              context.go(item['route'] as String);
            }
          },
          child:
          Consumer<PaymentsProvider>(
            builder: (context, paymentStatusProvider, child) {
              final isLoading =
                  paymentStatusProvider.currentLoadingRoute == item['route'];

              return BuildGridItem(
                item: item,
                loadingStatus : isLoading, // Pass loading state only for this item
              );
            },
          ),

        );
      },
    );
  }
}

class ReportTabItem extends StatelessWidget {
  const ReportTabItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaymentTabItem();
  }
}
