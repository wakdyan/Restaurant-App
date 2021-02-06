import 'package:get/get.dart';

import '../data/providers/db_provider.dart';
import '../routes/app_pages.dart';

class FavoriteController extends GetxController {
  DBProvider _dbProvider;

  DBProvider get dbProvider => _dbProvider;

  @override
  void onInit() {
    _dbProvider = Get.find();

    super.onInit();
  }

  void moveToDetailPage(String id) =>
      Get.toNamed(AppRoutes.DETAIL, arguments: id);

  void removeRestaurantFromFavorite(String id) =>
      _dbProvider.removeRestaurantFromFavorite(id);
}
