import 'package:flutter/material.dart';

import '../themes/app_shimmer.dart';
import 'restaurant_tile.dart';

class ShimmerListTile extends StatelessWidget {
  final bool isCircle;

  const ShimmerListTile([this.isCircle = false]);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (_, __) {
        return isCircle
            ? ListTile(
                leading: AppShimmer.shimmerCircleLeading(),
                title: AppShimmer.shimmerLine(),
                subtitle: AppShimmer.shimmerLine(),
              )
            : RestaurantTile(
                leading: AppShimmer.shimmerRectLeading(),
                title: AppShimmer.shimmerLine(),
                subtitle: AppShimmer.shimmerLine(),
              );
      },
    );
  }
}
