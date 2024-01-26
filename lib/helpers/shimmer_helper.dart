import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  Widget buildBasicShimmer(
      {double height = double.infinity,
      double width = double.infinity,
      double radius = 6}) {
    return Shimmer.fromColors(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        baseColor: Colors.cyan[50]!,
        highlightColor: Colors.lightBlueAccent);
  }

  buildProductGridShimmer({scontroller, item_count = 10}) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.indigo.shade100,
          highlightColor: Colors.orangeAccent.shade100,
          child: Container(
            height: 200.h,
            width: 120.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          ),
        );
      },
    );
  }

  Widget buildBasicShimmerCustomRadius(
      {double height = double.infinity,
      double? width = double.infinity,
      BorderRadius radius = BorderRadius.zero,
      Color color = Colors.grey}) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: Colors.amberAccent,
      child: Container(
        height: height,
        width: width,
        decoration:
            BoxDecoration(borderRadius: radius, color: Colors.purple[100]),
      ),
    );
  }

  Widget buildBasicShimmerForCategoryHorizontalList(
      {double height = double.infinity,
      double? width = double.infinity,
      BorderRadius radius = BorderRadius.zero,
      Color color = Colors.grey}) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: Colors.amberAccent,
      child: Container(
        height: height,
        width: width,
        decoration:
            BoxDecoration(borderRadius: radius, color: Colors.purple[100]),
      ),
    );
  }
}
