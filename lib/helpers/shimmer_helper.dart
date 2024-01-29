import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  Widget buildBasicShimmer(
      {double height = double.infinity,
      double width = double.infinity,
      double radius = 6}) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 243, 254, 255)!,
      highlightColor: Color.fromARGB(255, 212, 247, 243),
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: const Color.fromARGB(255, 221, 201, 224))),
    );
  }

  buildProductGridShimmer({scontroller, item_count = 10}) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 243, 254, 255)!,
          highlightColor: Color.fromARGB(255, 197, 217, 215),
          child: Container(
              height: 200.h,
              width: 150.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 221, 201, 224))),
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
      Color color = const Color.fromARGB(255, 215, 211, 211)}) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: const Color.fromARGB(255, 247, 242, 226),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: radius,
            color: const Color.fromARGB(255, 221, 201, 224)),
      ),
    );
  }

  buildVoucherGridShimmer({scontroller, item_count = 10}) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 243, 254, 255)!,
          highlightColor: Color.fromARGB(255, 197, 217, 215),
          child: Container(
              height: 100.h,
              width: 130.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 221, 201, 224))),
        );
      },
    );
  }
}
