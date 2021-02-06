import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controllers/controller.dart';
import '../data/models/detail_restaurant.dart';
import '../data/models/restaurant.dart';
import '../data/models/review.dart';
import '../themes/theme.dart';
import '../utils/enums.dart';
import '../widgets/failed_view.dart';
import '../widgets/persistent_header_delegate.dart';
import '../widgets/restaurant_tile.dart';
import '../widgets/shimmer_tile.dart';

class DetailPage extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(
          () {
            return Stack(
              children: [
                if (controller.requestState.value == ProgressState.done)
                  _buildSuccessView()
                else if (controller.requestState.value == ProgressState.failed)
                  FailedView(controller.getRestaurantDetailFromApi)
                else
                  _buildWaitingView(),
                _buildAppBarButton(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    var restaurant = controller.restaurantDetail.value;
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      controller: controller.scrollController,
      slivers: [
        _buildSliverAppBar(restaurant),
        _buildRestaurantInfo(restaurant),
        _buildReview(restaurant),
        _buildPersistentMenuLabel('Makanan'),
        _buildMenuList(restaurant.menu.foods),
        _buildPersistentMenuLabel('Minuman'),
        _buildMenuList(restaurant.menu.drinks)
      ],
    );
  }

  Widget _buildWaitingView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 2 / 1,
            child: AppShimmer.shimmerRect(),
          ),
          ListTile(
            title: AppShimmer.shimmerLine(),
            subtitle: AppShimmer.shimmerLine(),
          ),
          ShimmerListTile(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildReview(DetailRestaurant restaurant) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Review ${restaurant.customerReviews.length ?? ''}'),
            trailing: Icon(Icons.unfold_more),
            onTap: () => _showReviewSheet(restaurant.customerReviews),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              onTap: _showReviewTextFieldSheet,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Tulis review Anda',
              ),
            ),
          ),
          Divider(indent: 16, endIndent: 16),
        ],
      ),
    );
  }

  ListTile _buildReviewItem(Review customerReview) {
    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundColor: AppColor.primary,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(customerReview.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(customerReview.review),
          Text(
            customerReview.date,
            style: Get.textTheme.caption,
            strutStyle: StrutStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  SliverPersistentHeader _buildPersistentMenuLabel(String label) {
    return SliverPersistentHeader(
      delegate: PersistentHeaderDelegate(label),
      pinned: true,
    );
  }

  SliverList _buildMenuList(List<String> menus) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => RestaurantTile(
          leading: Image.asset('assets/blank.jpg', fit: BoxFit.cover),
          title: Text(menus[index]),
        ),
        childCount: menus.length,
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(DetailRestaurant restaurant) {
    final baseImageUrl = 'https://restaurant-api.dicoding.dev/images/large';
    return SliverAppBar(
      pinned: true,
      expandedHeight: 175,
      leading: SizedBox(),
      backgroundColor: AppColor.primary,
      title: Obx(
        () => AnimatedOpacity(
          duration: Duration(milliseconds: 100),
          opacity: controller.opacity.value,
          child: Text(
            restaurant.name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: '$baseImageUrl/${restaurant.pictureId}',
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: AppColor.highlight),
        ),
        stretchModes: [StretchMode.zoomBackground],
      ),
    );
  }

  Widget _buildAppBarButton() {
    return Positioned(
      top: 8,
      left: 8,
      right: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: controller.opacity.value == 1
                ? Colors.transparent
                : Colors.black54,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Visibility(
            visible: controller.requestState.value == ProgressState.done
                ? true
                : false,
            child: CircleAvatar(
              backgroundColor: controller.opacity.value == 1
                  ? Colors.transparent
                  : Colors.black54,
              child: IconButton(
                onPressed: controller.onFavoritePressed,
                icon: ValueListenableBuilder<Box<Restaurant>>(
                  valueListenable:
                      controller.dbProvider.favoriteBox.listenable(),
                  builder: (_, box, __) {
                    return box.containsKey(controller.id)
                        ? Icon(Icons.favorite, color: Colors.redAccent)
                        : Icon(Icons.favorite_outline, color: Colors.white);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildRestaurantInfo(DetailRestaurant restaurant) {
    String category =
        controller.separateCategoriesWithComma(restaurant.categories);

    return SliverToBoxAdapter(
      child: SizedBox(
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              title: Text(
                '${restaurant.name} - ${restaurant.city}',
                style: AppTextStyle.bold,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category),
                  RichText(
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
                        TextSpan(text: '${restaurant.rating.toDouble()}'),
                        WidgetSpan(
                          child: SizedBox(
                            height: 14,
                            child: VerticalDivider(),
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                        ),
                        TextSpan(text: '${restaurant.address}'),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: RotationTransition(
                turns: controller.animationController,
                child: Icon(Icons.expand_less),
              ),
              onTap: () {
                if (controller.hasChange.value)
                  controller.animationController.reverse();
                else
                  controller.animationController.forward();

                controller.hasChange.value = !controller.hasChange.value;
              },
            ),
            Divider(indent: 16, endIndent: 16),
            Visibility(
              visible: controller.hasChange.value,
              child: Column(
                children: [
                  ListTile(
                    subtitle:
                        Text(controller.restaurantDetail.value.description),
                  ),
                  Divider(indent: 16, endIndent: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewSheet(List<Review> customerReviews) {
    Get.bottomSheet(
      Container(
        height: Get.height - (Get.width / 1.8),
        width: Get.width,
        child: Column(
          children: [
            Material(
              elevation: 4,
              child: ListTile(
                title: Text('Review ${customerReviews.length ?? ''}'),
                trailing: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: customerReviews.length,
                itemBuilder: (_, index) =>
                    _buildReviewItem(customerReviews[index]),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  void _showReviewTextFieldSheet() {
    controller.textEditingController.clear();
    Get.bottomSheet(
      ListTile(
        tileColor: Colors.white,
        title: TextField(
          controller: controller.textEditingController,
          onChanged: (value) => controller.update(),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintText: 'Tulis review Anda',
          ),
        ),
        trailing: GetBuilder<DetailController>(
          builder: (controller) {
            if (controller.textEditingController.text.isEmpty)
              return SizedBox();
            else {
              return Obx(() {
                if (controller.sendState.value == ProgressState.busy)
                  return CircularProgressIndicator(
                      backgroundColor: AppColor.primary);
                return IconButton(
                  onPressed: controller.sendReview,
                  icon: Icon(Icons.send),
                );
              });
            }
          },
        ),
      ),
      isDismissible: false,
    );
  }
}
