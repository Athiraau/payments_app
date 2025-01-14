import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/features/bread_crumbs/view/bread_crumbs.dart';
import 'package:payments_application/features/others/controller/others_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/component/widgets/item_card_widget.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../bank_reconcilation/view/bank_reconcilation.dart';
import '../../payments/controller/payments_controller.dart';

class OthersPage extends StatelessWidget {
  const OthersPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
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
            BreadCrumbs(title: 'Others Page',),
            SizedBox(
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
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              labelTxtStyle:
                              const TextStyle(color: AppColor.txtFieldItemColor,fontFamily: 'poppinsRegular'),
                              hintTxtStyle:
                              const TextStyle(color: AppColor.txtFieldItemColor),
                              onChanged: (value) {
                                context.read<OthersProvider>().searchItems(value);
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
                      const SizedBox(height: 15),
                    Center(
                      child: Text(
                        "PAN CARD",
                        style:     TextStyle(color: AppColor.drawerColor,fontSize: 15,fontFamily: 'poppinsSemiBold'),
                      ),
                    ),
                      Divider(color: AppColor.dividerColor,),
                      const SizedBox(height: 10),
                      const Expanded(child: OthersPageItem())
                    ],
                  )),
            ))
          ],
        ),
      ),
    );
  }
}

class OthersPageItem extends StatelessWidget {
  const OthersPageItem({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final homeProvider = Provider.of<OthersProvider>(context);
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    if (homeProvider.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMobile
            ? ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ShimmerWidget(height: 100, width: double.infinity),
          ),
        )
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          itemCount: 6,
          itemBuilder: (context, index) =>
              ShimmerWidget(height: 100, width: double.infinity),
        ),
      );
    }

    if (homeProvider.filteredItems.isEmpty) {
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
      itemCount: homeProvider.filteredItems.length,
      itemBuilder: (context, index) {
        final item = homeProvider.filteredItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: GestureDetector(
            onTap: () {
              context.go(item['route'] as String);
            },
            child: SizedBox(
              height: 100,
              child: BuildCardItem(item: item,),
            ),
          ),
        );
      },
    )
        : GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemCount: homeProvider.filteredItems.length,
      itemBuilder: (context, index) {
        final item = homeProvider.filteredItems[index];
        return GestureDetector(
          onTap: () {
            context.go(item['route'] as String);
          },
          child: BuildGridItem(item: item,),
        );
      },
    );
  }
}


