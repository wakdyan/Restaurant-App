import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../utils/app_color.dart';
import '../utils/app_theme.dart';
import '../widgets/restaurant_tile.dart';
import '../widgets/shimmer_tile.dart';
import 'detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  static final route = '/home';
  final _restaurants = <Restaurant>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Text(
              'Restaurant App',
              style: TextStyle(color: AppColor.primary),
            ),
            bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextField(
                  onTap: () => _moveToSearchScreen(context),
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Cari restoran kesukaan kamu',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(83),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              title: Text(
                'Banyak resto enak, loh',
                style: AppTheme.bold,
              ),
              subtitle: Text('Coba rekomendasi dari kami, ya'),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Restaurant>>(
              future: _getRestaurantList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return Center(child: Text('Tidak ada data'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          final restaurant = snapshot.data[index];
                          return _buildRestaurantItem(context, restaurant);
                        },
                      );
                    }
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('Tidak ada data'));
                  } else {
                    return Center(child: Text(snapshot.error));
                  }
                } else {
                  return ShimmerTile(false);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return RestaurantTile(
      onTap: () => _moveToDetailScreen(context, restaurant),
      leading: CachedNetworkImage(
        imageUrl: restaurant.pictureUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: AppColor.highlight),
      ),
      title: Text(
        '${restaurant.name} - ${restaurant.city}',
        style: AppTheme.bold,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: RichText(
        strutStyle: StrutStyle(fontSize: 24),
        text: TextSpan(
          style: AppTheme.bold.copyWith(color: AppColor.text),
          children: [
            WidgetSpan(
              child: Icon(
                Icons.star_rounded,
                color: Colors.orangeAccent,
                size: 18,
              ),
            ),
            TextSpan(text: '${restaurant.rating.toDouble()}'),
          ],
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).disabledColor,
      ),
    );
  }

  Future<List<Restaurant>> _getRestaurantList(BuildContext context) async {
    try {
      var results = await DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json');
      final Map<String, dynamic> parsed = jsonDecode(results);
      final List restaurants = parsed['restaurants'];
      restaurants.forEach((element) {
        _restaurants.add(Restaurant.fromJson(element));
      });
      return _restaurants;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  void _moveToDetailScreen(BuildContext context, Restaurant restaurant) {
    Navigator.pushNamed(context, DetailScreen.route, arguments: restaurant);
  }

  void _moveToSearchScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      SearchScreen.route,
      arguments: _restaurants,
    );
  }
}
