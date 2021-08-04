import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../utils/app_color.dart';
import '../utils/app_theme.dart';
import '../widgets/persistent_header.dart';
import '../widgets/restaurant_tile.dart';

class DetailScreen extends StatefulWidget {
  static final route = '/detail';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  ScrollController _scrollController;
  bool _hasChange = false;
  double _opacity = 0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      value: 0,
      lowerBound: 0,
      upperBound: .5,
    );

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset <= 84)
          setState(() => _opacity = 0);
        else
          setState(() => _opacity = 1);
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context).settings.arguments as Restaurant;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 175,
                  leading: SizedBox(),
                  backgroundColor: AppColor.primary,
                  title: AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: _opacity,
                    child: Text(restaurant.name),
                  ),
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: restaurant.pictureUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return Container(color: AppColor.highlight);
                      },
                    ),
                    stretchModes: [StretchMode.zoomBackground],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${restaurant.name} - ${restaurant.city}',
                            style: AppTheme.bold,
                          ),
                          subtitle: RichText(
                            strutStyle: StrutStyle(fontSize: 24),
                            text: TextSpan(
                              style:
                                  AppTheme.bold.copyWith(color: AppColor.text),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.star_rounded,
                                    color: Colors.orangeAccent,
                                    size: 18,
                                  ),
                                ),
                                TextSpan(
                                    text: '${restaurant.rating.toDouble()}'),
                              ],
                            ),
                          ),
                          trailing: RotationTransition(
                            turns: _animationController,
                            child: Icon(Icons.keyboard_arrow_up),
                          ),
                          onTap: () {
                            if (_hasChange) {
                              _animationController.reverse();
                            } else {
                              _animationController.forward();
                            }

                            setState(() => _hasChange = !_hasChange);
                          },
                        ),
                        Divider(indent: 16, endIndent: 16),
                        Visibility(
                          visible: _hasChange,
                          child: Column(
                            children: [
                              ListTile(subtitle: Text(restaurant.description)),
                              Divider(indent: 16, endIndent: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentHeader('Makanan'),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return RestaurantTile(
                        leading: Image.asset(
                          'assets/blank.jpg',
                          fit: BoxFit.cover,
                        ),
                        title: Text(restaurant.menu.foods[index]),
                      );
                    },
                    childCount: restaurant.menu.foods.length,
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentHeader('Minuman'),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return RestaurantTile(
                        leading: Image.asset(
                          'assets/blank.jpg',
                          fit: BoxFit.cover,
                        ),
                        title: Text(restaurant.menu.drinks[index]),
                      );
                    },
                    childCount: restaurant.menu.drinks.length,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              left: 8,
              child: CircleAvatar(
                backgroundColor:
                    _opacity == 1 ? Colors.transparent : Colors.black54,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
