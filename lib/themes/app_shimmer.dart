import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'app_color.dart';

class AppShimmer {
  static Widget shimmerLine() {
    return Shimmer.fromColors(
      child: Container(
        height: 14,
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      baseColor: Colors.grey[200],
      highlightColor: AppColor.highlight,
    );
  }

  static Widget shimmerRect() {
    return Shimmer.fromColors(
      child: Container(color: Colors.white),
      baseColor: Colors.grey[200],
      highlightColor: AppColor.highlight,
    );
  }

  static Widget shimmerRectLeading() {
    return Shimmer.fromColors(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      baseColor: Colors.grey[200],
      highlightColor: AppColor.highlight,
    );
  }

  static Widget shimmerCircleLeading() {
    return Shimmer.fromColors(
      child: CircleAvatar(),
      baseColor: Colors.grey[200],
      highlightColor: AppColor.highlight,
    );
  }
}
