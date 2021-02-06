import 'package:get/get.dart';

import '../controllers/controller.dart';
import '../data/providers/api_provider.dart';
import '../pages/pages.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => ApiProvider());
      }),
    ),
    GetPage(
      name: AppRoutes.DETAIL,
      page: () => DetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => SearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SearchController());
      }),
    ),
    GetPage(
      name: AppRoutes.FAVORITE,
      page: () => FavoritePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FavoriteController());
      }),
    ),
    GetPage(
      name: AppRoutes.SETTING,
      page: () => SettingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SettingController());
      }),
    ),
  ];
}
