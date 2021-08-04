import 'package:flutter/material.dart';

import '../utils/app_shimmer.dart';
import 'restaurant_tile.dart';

class ShimmerTile extends StatelessWidget {
  final bool isCircle;

  const ShimmerTile(this.isCircle);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 5,
      itemBuilder: (_, __) {
        if (isCircle) {
          return ListTile(
            leading: AppShimmer.shimmerCircleLeading(),
            title: AppShimmer.shimmerLine(),
            subtitle: AppShimmer.shimmerLine(),
          );
        } else {
          return RestaurantTile(
            leading: AppShimmer.shimmerRectLeading(),
            title: AppShimmer.shimmerLine(),
            subtitle: AppShimmer.shimmerLine(),
          );
        }
      },
    );
  }
}
