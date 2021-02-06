import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/restaurant.dart';

class DBProvider extends GetxService {
  Box<Restaurant> _favoriteBox;
  Box<bool> _settingBox;

  Box<Restaurant> get favoriteBox => _favoriteBox;
  Box<bool> get settingBox => _settingBox;

  Future<DBProvider> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RestaurantAdapter());

    _favoriteBox = await Hive.openBox<Restaurant>('favorite');
    _settingBox = await Hive.openBox<bool>('setting');

    return this;
  }

  Future<void> addRestaurantToFavorite(Restaurant restaurant) =>
      _favoriteBox.put(restaurant.id, restaurant);

  List<Restaurant> getFavorites() => _favoriteBox.values.map((e) => e).toList();

  Future<void> removeRestaurantFromFavorite(String id) =>
      _favoriteBox.delete(id);

  Future<void> changeSchedule(bool value) =>
      _settingBox.put('isScheduled', value);
}
