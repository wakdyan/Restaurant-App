import 'package:flutter/material.dart';

import '../themes/app_text_style.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  PersistentHeaderDelegate(this.title);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(title, style: AppTextStyle.bold),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
