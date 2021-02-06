import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controllers/setting_controller.dart';
import '../themes/app_color.dart';

class SettingPage extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<Box<bool>>(
        valueListenable: controller.dbProvider.settingBox.listenable(),
        builder: (_, box, __) {
          return SwitchListTile(
            value: box.get('isScheduled', defaultValue: false),
            onChanged: (value) => controller.changeSchedule(value),
            activeColor: AppColor.primary,
            isThreeLine: true,
            title: Text('Notifikasi harian'),
            subtitle: Text(
                'Dapatkan notifikasi rekomendasi restoran setiap hari pukul 11.00 WIB.'),
          );
        },
      ),
    );
  }
}
