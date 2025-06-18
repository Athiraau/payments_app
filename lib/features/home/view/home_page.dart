import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/helpers/session/controller/session_controller.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/component/widgets/item_card_widget.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../bread_crumbs/view/bread_crumbs.dart';
import '../../drawer/controller/drawer_controller.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
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
            children: [
              const BreadCrumbs(
                title: 'Home Page',
              ),
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
                    padding: const EdgeInsets.all(12.0),
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
                                controller: homeProvider.searchController,
                                keyboardType: TextInputType.text,
                                labelTxtStyle: const TextStyle(
                                    color: AppColor.txtFieldItemColor),
                                hintTxtStyle: const TextStyle(
                                    color: AppColor.txtFieldItemColor),
                                onChanged: (value) {
                                  context.read<HomeProvider>().searchItems(value);
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
                        Expanded(child: HomePageItem(provider: homeProvider,)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}

class HomePageItem extends StatelessWidget {
  final HomeProvider provider;
  const HomePageItem({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final sliderController = Provider.of<SliderProvider>(context);
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 3 : 4);
    if (provider.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMobile
            ? ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: ShimmerWidget(height: 100, width: double.infinity),
          ),
        )
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.2,
          ),
          itemCount: 6,
          itemBuilder: (context, index) =>
          const ShimmerWidget(height: 100, width: double.infinity),
        ),
      );
    }

    if (provider.filteredItems.isEmpty) {
      return const Center(
        child: Text(
          "No items found",
          style: TextStyle(
            color: AppColor.drawerColor,
            fontSize: 16,
            fontFamily: 'poppinsRegular',
          ),
        ),
      );
    }

    return isMobile
        ? ListView.builder(
      itemCount: provider.filteredItems.length,
      itemBuilder: (context, index) {
        final item = provider.filteredItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
              height: 70,
              child: Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  homeProvider.curIndex = index;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: homeProvider.curIndex ==
                            homeProvider.selectedIndex
                            ? AppColor.cardTitleColor
                            : AppColor.dividerColor,
                        width: 1,
                      ),
                    ),
                    child: BuildCardItem(
                      curIndex: index,
                      selectedIndex: homeProvider.loadingIndex,
                      item: item,
                      onTap: () {
                        sliderController.selectedItem = item['title']!;
                        sliderController.chkIsSelected(
                            title: item['title'].toString());
                        context.go(item['route'] as String);
                      },
                    ),
                  );
                },
              )),
        );
      },
    )
        : GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.2,
      ),
      itemCount: provider.filteredItems.length,
      itemBuilder: (context, index) {
        final item = provider.filteredItems[index];
        provider.curIndex = index;
        return MouseRegion(
          opaque: false,
          cursor: MouseCursor.defer,
          onEnter: (_) => provider.onEnter(index),
          onExit: (_) => provider.onExit(),
          onHover: (_) {
            provider.selectedIndex = index;
          },
          child: Transform.scale(
            scale: provider.selectedIndex == index ? 1.0 : 0.96,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: provider.curIndex ==
                      provider.selectedIndex
                      ? AppColor.cardTitleColor
                      : AppColor.dividerColor,
                  width: 1,
                ),
              ),
              child: BuildGridItem(
                item: item,
                onTap: () {
                  sliderController.selectedItem = item['title']!;
                  sliderController.chkIsSelected(
                      title: item['title'].toString());
                  context.go(item['route'] as String);
                },
                curIndex: index,
                selectedIndex: provider.loadingIndex,
              ),
            ),
          ),
        );
      },
    );
  }
}
