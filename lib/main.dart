import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'data/providers/db_provider.dart';
import 'routes/app_pages.dart';
import 'themes/theme.dart';
import 'utils/notification_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));

  await initServices();

  runApp(MyApp());
}

Future<void> initServices() async {
  await AndroidAlarmManager.initialize();

  await Get.putAsync(() => DBProvider().init());
  await Get.putAsync(() => NotificationHelper().init(), permanent: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Restaurant App',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.pages,
    );
  }
}
