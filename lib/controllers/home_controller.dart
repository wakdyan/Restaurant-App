import 'package:get/get.dart';

import '../data/models/restaurant.dart';
import '../data/providers/api_provider.dart';
import '../routes/app_pages.dart';
import '../utils/enums.dart';

class HomeController extends GetxController {
  ApiProvider _apiProvider;
  RxList<Restaurant> _restaurants = RxList<Restaurant>();
  Rx<ProgressState> _requestState = ProgressState.idle.obs;

  Rx<ProgressState> get requestState => _requestState;
  RxList<Restaurant> get restaurants => _restaurants;

  @override
  void onInit() {
    _apiProvider = Get.find();

    super.onInit();
  }

  @override
  void onReady() {
    fetchRestaurantFromApi();

    super.onReady();
  }

  void fetchRestaurantFromApi() {
    _restaurants.clear();
    _requestState.value = ProgressState.busy;
    _apiProvider.getRestaurantList().then((value) {
      if (value.statusCode == 200) {
        List response = value.body['restaurants'];
        restaurants.addAll(response.map((e) => Restaurant.fromJson(e)));
        _requestState.value = ProgressState.done;
      } else {
        Future.delayed(
          Duration(seconds: 5),
          () => _requestState.value = ProgressState.failed,
        );
      }
    });
  }

  void moveToDetailPage(String id) =>
      Get.toNamed(AppRoutes.DETAIL, arguments: id);

  void moveToSearchPage() => Get.toNamed(AppRoutes.SEARCH);

  void moveToFavoritePage() => Get.toNamed(AppRoutes.FAVORITE);

  void moveToSettingPage() => Get.toNamed(AppRoutes.SETTING);
}
