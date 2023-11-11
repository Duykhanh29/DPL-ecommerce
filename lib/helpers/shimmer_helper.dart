import 'package:flutter/material.dart';
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
}
