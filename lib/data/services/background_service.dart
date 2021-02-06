import 'dart:math';

import 'package:get/get.dart';

import '../models/restaurant.dart';
import '../providers/api_provider.dart';
import '../../utils/notification_helper.dart';

class BackgroundService {
  static Future<void> callback() async {
    final apiProvider = Get.put(ApiProvider());
    final notificationService = Get.put(NotificationHelper());

    await apiProvider.getRestaurantList().then((value) {
      if (value.statusCode == 200) {
        List response = value.body['restaurants'];
        var restaurants = response.map((e) => Restaurant.fromJson(e)).toList();
        var random = Random();
        var index = random.nextInt(restaurants.length);
        var selectedRestaurant = restaurants[index];

        notificationService.showNotification(selectedRestaurant);
      }
    });
  }
}
