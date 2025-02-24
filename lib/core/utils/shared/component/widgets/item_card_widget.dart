import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payments_application/core/utils/config/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

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

  const BuildCardItem({
    Key? key,
    required this.item,
    this.loadingStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: item['cardColor'] as Color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: loadingStatus == null || loadingStatus == false
            ? Column(
                children: [
                  SvgPicture.asset(
                    item['logo'] as String,
                    width: 25,
                    height: 25,
                    color: item['cardTitle'] as Color,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomText(
                      text: item['title'] as String,
                      color: item['cardTitle'] as Color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'poppinsRegular', // Set fontFamily
                    ),
                  ),
                ],
              )
            :   Container(
      color:  item['cardColor'] as Color
      , // Semi-transparent overlay
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    ),
      ),
    );
  }
}

// Grid Item Widget Class
class BuildGridItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool? loadingStatus;
  const BuildGridItem({
    Key? key,
    required this.item,
    this.loadingStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item['cardColor'] as Color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:loadingStatus == null || loadingStatus == false? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                SvgPicture.asset(
                  item['logo'] as String,
                  width: 40,
                  height: 40,
                  color: item['cardTitle'] as Color,
                ),
                const SizedBox(height: 8),
                CustomText(
                  text: item['title'] as String,
                  color: item['cardTitle'] as Color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'poppinsRegular', // Set fontFamily
                ),
              ],
            ): Container(
        color:  item['cardColor'] as Color
        , // Semi-transparent overlay
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
    );

  }
}
