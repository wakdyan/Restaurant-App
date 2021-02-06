import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controllers/favorite_controller.dart';
import '../data/models/restaurant.dart';
import '../themes/app_color.dart';
import '../themes/app_text_style.dart';
import '../widgets/empty_view.dart';
import '../widgets/restaurant_tile.dart';

class FavoritePage extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restoran Favorite')),
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<Box<Restaurant>>(
        valueListenable: controller.dbProvider.favoriteBox.listenable(),
        builder: (_, box, __) {
          return box.isEmpty
              ? EmptyView(
                  imagePath: 'assets/undraw_taken.png',
                  title: 'Tidak ada favorit',
                  subtitle:
                      'Pastikan kamu sudah menekan tombol favorit pada restoran langgananmu.',
                )
              : _buildFavoriteList(box);
        },
      ),
    );
  }

  Widget _buildFavoriteList(Box<Restaurant> box) {
    return ListView(
      shrinkWrap: true,
      children: box.values.map((restaurant) {
        return _buildFavoriteItem(
          Restaurant(
            id: restaurant.id,
            name: restaurant.name,
            city: restaurant.city,
            pictureId: restaurant.pictureId,
            rating: restaurant.rating,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFavoriteItem(Restaurant restaurant) {
    var imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/small';
    return RestaurantTile(
      onTap: () => controller.moveToDetailPage(restaurant.id),
      leading: CachedNetworkImage(
        imageUrl: '$imageBaseUrl/${restaurant.pictureId}',
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: AppColor.highlight),
      ),
      title: Text(
        '${restaurant.name} - ${restaurant.city}',
        style: AppTextStyle.bold,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: RichText(
        strutStyle: StrutStyle(fontSize: 24),
        text: TextSpan(
          style: AppTextStyle.bold.copyWith(color: AppColor.text),
          children: [
            WidgetSpan(
              child: Icon(
                Icons.star_rounded,
                color: Colors.orangeAccent,
                size: 18,
              ),
            ),
            TextSpan(text: '${restaurant.rating?.toDouble()}'),
          ],
        ),
      ),
      trailing: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert, color: Colors.black45),
        onSelected: (id) => controller.removeRestaurantFromFavorite(id),
        itemBuilder: (_) {
          return [
            PopupMenuItem<String>(
              value: restaurant.id,
              child: Text('Hapus dari favorit'),
            ),
          ];
        },
      ),
    );
  }
}
