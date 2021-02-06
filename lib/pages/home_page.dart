import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../data/models/restaurant.dart';
import '../themes/theme.dart';
import '../utils/enums.dart';
import '../widgets/failed_view.dart';
import '../widgets/restaurant_tile.dart';
import '../widgets/shimmer_tile.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [_buildSliverAppBar()],
        body: _buildBody(),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      title: Text('Restaurant App'),
      actions: [
        IconButton(
          onPressed: controller.moveToFavoritePage,
          icon: Icon(Icons.favorite),
        ),
        IconButton(
          onPressed: controller.moveToSettingPage,
          icon: Icon(Icons.settings),
        ),
      ],
      bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: TextField(
            onTap: controller.moveToSearchPage,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Cari restoran kesukaan kamu',
              prefixIcon: Icon(Icons.search, color: Get.theme.hintColor),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(83),
      ),
    );
  }

  Obx _buildBody() {
    return Obx(
      () => controller.requestState.value == ProgressState.done
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Banyak resto enak, loh',
                      style: AppTextStyle.bold,
                    ),
                    subtitle: Text('Coba rekomendasi dari kami, ya'),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.restaurants.length,
                    itemBuilder: (_, index) {
                      final restaurant = controller.restaurants[index];

                      return _buildRestaurantItem(restaurant);
                    },
                  ),
                ],
              ),
            )
          : controller.requestState.value == ProgressState.failed
              ? FailedView(controller.fetchRestaurantFromApi)
              : ShimmerListTile(),
    );
  }

  Widget _buildRestaurantItem(Restaurant restaurant) {
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
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Get.theme.disabledColor,
      ),
    );
  }
}
