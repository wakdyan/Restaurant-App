import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/restaurant.dart';
import '../data/providers/api_provider.dart';
import '../routes/app_pages.dart';
import '../utils/enums.dart';

class SearchController extends GetxController {
  TextEditingController _textController;
  ApiProvider _restaurantProvider;
  RxList<Restaurant> _results = RxList<Restaurant>();
  Rx<ProgressState> _requestState = ProgressState.idle.obs;

  Rx<ProgressState> get requestState => _requestState;
  RxList<Restaurant> get results => _results;
  TextEditingController get textController => _textController;

  @override
  void onInit() {
    _textController = TextEditingController();
    _restaurantProvider = Get.find();

    super.onInit();
  }

  @override
  void onClose() {
    _textController.dispose();

    super.onClose();
  }

  void search() {
    if (_textController.text.length < 3)
      _requestState.value = ProgressState.idle;
    else {
      _requestState.value = ProgressState.busy;
      _restaurantProvider.searchRestaurant(_textController.text).then((value) {
        if (value.statusCode == 200) {
          bool founded = value.body['founded'] > 0;
          if (founded) {
            _results.clear();

            List response = value.body['restaurants'];
            _results.addAll(response.map((e) => Restaurant.fromJson(e))
              ..where((element) => element.name.contains(_textController.text))
              ..toSet());
            _requestState.value = ProgressState.done;
          } else
            _requestState.value = ProgressState.empty;
        } else {
          Future.delayed(
            Duration(seconds: 3),
            () => _requestState.value = ProgressState.failed,
          );
        }
      });
    }
  }

  void clearSearchQuery() {
    if (_textController.text.isNotEmpty) {
      _textController.clear();
      _requestState.value = ProgressState.idle;
    }
  }

  void moveToDetailScreen(String id) =>
      Get.toNamed(AppRoutes.DETAIL, arguments: id);
}
