import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../data/models/restaurant.dart';
import '../routes/app_pages.dart';

class NotificationHelper extends GetxService {
  final _localNotification = FlutterLocalNotificationsPlugin();
  final _androidSettings = AndroidInitializationSettings('ic_notification');

  Future<NotificationHelper> init() async {
    var initializeSettings = InitializationSettings(android: _androidSettings);

    _localNotification.initialize(
      initializeSettings,
      onSelectNotification: (payload) => _moveToRestaurantDetail(payload),
    );

    return this;
  }

  Future<void> _moveToRestaurantDetail(String payload) =>
      Get.toNamed<void>(AppRoutes.DETAIL, arguments: payload);

  Future<void> showNotification(Restaurant restaurant) async {
    var channelId = 'restaurant';
    var channelName = 'restaurant recommendation';
    var channelDescription = 'show daily restaurant recommendation';

    var androidNotificationDetail = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      ticker: 'ticker',
      enableVibration: true,
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    var notificationDetails =
        NotificationDetails(android: androidNotificationDetail);

    await _localNotification.show(
      0,
      'Rekomendasi Restoran',
      restaurant.name,
      notificationDetails,
      payload: restaurant.id,
    );
  }
}
