import 'package:flutter/material.dart';

class RestaurantTile extends StatelessWidget {
  final Widget leading;
  final Widget subtitle;
  final Widget title;
  final Widget trailing;
  final GestureTapCallback onTap;

  const RestaurantTile({
    this.leading,
    this.subtitle,
    this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16),
              height: 80,
              width: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: leading,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        title,
                        subtitle != null ? SizedBox(height: 4) : SizedBox(),
                        subtitle ?? SizedBox(),
                      ],
                    ),
                  ),
                  trailing ?? SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
