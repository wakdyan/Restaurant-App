import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:get/get.dart';

import '../data/providers/db_provider.dart';
import '../data/services/background_service.dart';
import '../utils/date_helper.dart';

class SettingController extends GetxController {
  DBProvider _dbProvider;

  DBProvider get dbProvider => _dbProvider;

  @override
  void onInit() {
    _dbProvider = Get.find();

    super.onInit();
  }

  void changeSchedule(bool value) {
    _dbProvider.changeSchedule(value).whenComplete(() async {
      if (value)
        await AndroidAlarmManager.periodic(
          const Duration(days: 1),
          1,
          BackgroundService.callback,
          wakeup: true,
          exact: true,
          rescheduleOnReboot: true,
          startAt: DateHelper.scheduledTime,
        );
      else
        await AndroidAlarmManager.cancel(1);
    });
  }
}
