import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/component/widgets/item_card_widget.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/sbi_controller.dart';

class SbiPage extends StatefulWidget {
  const SbiPage({super.key});

  @override
  State<SbiPage> createState() => _SbiPageState();
}

class _SbiPageState extends State<SbiPage> {
  final TextEditingController searchController = TextEditingController();
  late SbiProvider sbiProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sbiProvider = Provider.of<SbiProvider>(context);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => sbiProvider.setTabIndex(0));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            const BreadCrumbs(title: 'SBI Page'),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: size.width,
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
                            ///Search bar
                            SizedBox(
                              width: size.width * 0.50,
                              height: 40,
                              child: CustomTextField(
                                labelTxt: 'Search',
                                hintTxt: 'Enter text',
                                controller: searchController,
                                keyboardType: TextInputType.text,
                                labelTxtStyle: const TextStyle(
                                  color: AppColor.txtFieldItemColor,
                                ),
                                hintTxtStyle: const TextStyle(
                                  color: AppColor.txtFieldItemColor,
                                ),
                                onChanged: (value) {
                                  if (mounted) {
                                    sbiProvider.searchItems(value);
                                  }
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
                              sbiProvider.setTabIndex(index);
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
                              Tab(text: "Sbi"),
                              Tab(text: "Reports"),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TabBarView(
                              children: [SbiTabItem(), ReportTabItem()],
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

class SbiTabItem extends StatefulWidget {
  const SbiTabItem({super.key});

  @override
  State<SbiTabItem> createState() => _SbiTabItemState();
}

class _SbiTabItemState extends State<SbiTabItem> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final bankRecoProvider = Provider.of<SbiProvider>(context, listen: false);
      bankRecoProvider.setTabIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<SbiProvider>(
      builder: (context, sbiProvider, child) {
        final isMobile = size.width < 600;
        final isTablet = size.width >= 600 && size.width < 1024;
        final crossAxisCount = isMobile ? 1 : (isTablet ? 3 : 4);

        if (sbiProvider.isLoading) {
          return isMobile
              ? shimmerListView(itemCount: 6)
              : shimmerGridView(crossAxisCount: crossAxisCount, itemCount: 6);
        }

        if (sbiProvider.filteredItems.isEmpty) {
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
            ? buildListView(sbiProvider.filteredItems)
            : buildGridView(sbiProvider.filteredItems, crossAxisCount);
      },
    );
  }
}

class ReportTabItem extends StatefulWidget {
  const ReportTabItem({super.key});

  @override
  State<ReportTabItem> createState() => _ReportTabItemState();
}

class _ReportTabItemState extends State<ReportTabItem> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final bankRecoProvider = Provider.of<SbiProvider>(context, listen: false);
      bankRecoProvider.setTabIndex(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<SbiProvider>(
      builder: (context, sbiProvider, child) {
        final isMobile = size.width < 600;
        final isTablet = size.width >= 600 && size.width < 1024;
        final crossAxisCount = isMobile ? 1 : (isTablet ? 3 : 4);

        if (sbiProvider.isLoading) {
          return isMobile
              ? shimmerListView(itemCount: 6)
              : shimmerGridView(crossAxisCount: crossAxisCount, itemCount: 6);
        }

        if (sbiProvider.filteredItems.isEmpty) {
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
            ? buildListView(sbiProvider.filteredItems)
            : buildGridView(sbiProvider.filteredItems, crossAxisCount);
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
        child: Consumer<SbiProvider>(
          builder: (context, sbiProvider, child) {
            sbiProvider.curIndex = index;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MouseRegion(
                opaque: false,
                cursor: MouseCursor.defer,
                onEnter: (_) => sbiProvider.onEnter(index),
                onExit: (_) => sbiProvider.onExit(),
                onHover: (_) {
                  sbiProvider.selectedIndex = index;
                },
                child: Transform.scale(
                  scale: sbiProvider.selectedIndex == index ? 1.0 : 0.96,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: sbiProvider.curIndex == sbiProvider.selectedIndex
                            ? AppColor.cardTitleColor
                            : AppColor.dividerColor,
                        width: 1,
                      ),
                    ),
                    child: BuildCardItem(
                      item: item,
                      onTap: () {
                        sbiProvider.loadingIndex = index;
                        context.go(item['route'] as String);
                      },
                      curIndex: sbiProvider.curIndex,
                      selectedIndex: sbiProvider.loadingIndex,
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
      return Consumer<SbiProvider>(
        builder: (context, sbiProvider, child) {
          sbiProvider.curIndex = index;
          return MouseRegion(
            opaque: false,
            cursor: MouseCursor.defer,
            onEnter: (_) => sbiProvider.onEnter(index),
            onExit: (_) => sbiProvider.onExit(),
            onHover: (_) {
              sbiProvider.selectedIndex = index;
            },
            child: Transform.scale(
              scale: sbiProvider.selectedIndex == index ? 1.0 : 0.96,
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
                        color: sbiProvider.curIndex == sbiProvider.selectedIndex
                            ? AppColor.cardTitleColor
                            : AppColor.dividerColor,
                        width: 1,
                      ),
                    ),
                    child: BuildGridItem(
                      item: item,
                      onTap: () {
                        sbiProvider.loadingIndex = index;
                        context.go(item['route'] as String);
                      },
                      curIndex: sbiProvider.curIndex,
                      selectedIndex: sbiProvider.loadingIndex,
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
