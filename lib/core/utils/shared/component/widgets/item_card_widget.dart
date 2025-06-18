import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/styles/colors.dart';
import 'custom_text.dart';

// Shimmer Widget Class
class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

// Card Item Widget Class

class BuildCardItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool? loadingStatus;
  final Function() onTap;
  final int curIndex;
  final int selectedIndex;

  const BuildCardItem({
    Key? key,
    required this.item,
    this.loadingStatus,
    required this.onTap,
    required this.curIndex,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: item['cardColor'] as Color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: loadingStatus == true && curIndex == selectedIndex
            ? const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: AppColor.drawerColor,
            ),
          ),
        )
            : Row(
          children: [
            SvgPicture.asset(
              item['logo'] as String,
              width: 25,
              height: 25,
              color: item['cardTitle'] as Color,
            ),
            const SizedBox(width: 15),
            Flexible(
              child: Text(
                item['title'] as String,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'poppinsRegular',
                  color: item['cardTitle'] as Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BuildGridItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool? loadingStatus;
  final Function() onTap;
  final int curIndex;
  final int selectedIndex;

  const BuildGridItem({
    Key? key,
    required this.item,
    this.loadingStatus,
    required this.onTap,
    required this.curIndex,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color cardColor = item['cardColor'] as Color;
    final Color cardTitleColor = item['cardTitle'] as Color;
    final String logoPath = item['logo'] as String;
    final String title = item['title'] as String;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: loadingStatus == true && curIndex == selectedIndex
            ? const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: AppColor.drawerColor,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  SvgPicture.asset(
                    logoPath,
                    width: 40,
                    height: 40,
                    color: cardTitleColor,
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'poppinsRegular',
                        color: cardTitleColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
