import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart';
import '../utils/enums.dart';
import '../widgets/empty_view.dart';
import '../widgets/failed_view.dart';
import '../widgets/shimmer_tile.dart';

class SearchPage extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                      child: TextField(
                        controller: controller.textController,
                        onChanged: (value) => controller.search(),
                        decoration: InputDecoration(
                          hintText: 'Cari restoran kesukaan kamu',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: controller.clearSearchQuery,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Obx(() {
                var state = controller.requestState.value;
                if (state == ProgressState.done)
                  return _buildSearchResults();
                else if (state == ProgressState.failed)
                  return FailedView(controller.search);
                else if (state == ProgressState.busy)
                  return ShimmerListTile(true);
                else if (state == ProgressState.idle)
                  return SizedBox();
                else
                  return EmptyView(
                    imagePath: 'assets/undraw_not_found.png',
                    title: 'Restoran tidak ditemukan',
                    subtitle:
                        'Pastikan kamu sudah mengetikkan nama restoran dengan benar',
                  );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.results.length,
      itemBuilder: (_, index) {
        var imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/small';
        var restaurant = controller.results[index];
        return ListTile(
          onTap: () => controller.moveToDetailScreen(restaurant.id),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                '$imageBaseUrl/${restaurant.pictureId}'),
          ),
          title: Text(controller.results[index].name),
          subtitle: Text(controller.results[index].city),
        );
      },
    );
  }
}
