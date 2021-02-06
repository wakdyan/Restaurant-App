import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/category.dart';
import '../data/models/detail_restaurant.dart';
import '../data/models/restaurant.dart';
import '../data/providers/api_provider.dart';
import '../data/providers/db_provider.dart';
import '../utils/enums.dart';

class DetailController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController _animationController;
  ScrollController _scrollController;
  TextEditingController _textEditingController;
  ApiProvider _apiProvider;
  DBProvider _dbProvider;
  String _id;
  RxDouble _opacity = 0.0.obs;
  RxBool _hasChange = false.obs;
  Rx<ProgressState> _requestState = ProgressState.idle.obs;
  Rx<ProgressState> _sendState = ProgressState.idle.obs;
  Rx<DetailRestaurant> _restaurantDetail = Rx<DetailRestaurant>();

  AnimationController get animationController => _animationController;
  ScrollController get scrollController => _scrollController;
  TextEditingController get textEditingController => _textEditingController;
  String get id => _id;
  RxBool get hasChange => _hasChange;
  RxDouble get opacity => _opacity;
  Rx<ProgressState> get requestState => _requestState;
  Rx<ProgressState> get sendState => _sendState;
  Rx<DetailRestaurant> get restaurantDetail => _restaurantDetail;
  DBProvider get dbProvider => _dbProvider;

  @override
  void onInit() {
    _id = Get.arguments;

    _dbProvider = Get.find();
    _apiProvider = Get.find();

    _textEditingController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      value: 0,
      lowerBound: 0,
      upperBound: .5,
    );
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 0 && _scrollController.offset <= 84) {
          _opacity.value = _scrollController.offset / 100;
        } else if (_scrollController.offset > 84)
          _opacity.value = 1;
        else
          _opacity.value = 0;
      });

    super.onInit();
  }

  @override
  void onReady() {
    getRestaurantDetailFromApi();

    super.onReady();
  }

  @override
  void onClose() {
    _animationController.dispose();
    _scrollController.dispose();
    _textEditingController.dispose();

    super.onClose();
  }

  void getRestaurantDetailFromApi() {
    _requestState.value = ProgressState.busy;
    _apiProvider.getRestaurantDetail(_id).then((value) {
      if (value.statusCode == 200) {
        _requestState.value = ProgressState.done;
        _restaurantDetail.value =
            DetailRestaurant.fromJson(value.body['restaurant']);
      } else {
        Future.delayed(
          Duration(seconds: 5),
          () => _requestState.value = ProgressState.failed,
        );
      }
    });
  }

  String separateCategoriesWithComma(List<Category> categories) {
    var category = [];
    categories.forEach((e) => category.add(e.name));
    return category.join(', ');
  }

  void sendReview() {
    _sendState.value = ProgressState.busy;

    _apiProvider.postReview(
      {
        'id': _restaurantDetail.value.id,
        'name': 'YOUR NAME',
        'review': _textEditingController.text.trim()
      },
    ).then((value) {
      if (value.statusCode == 200) {
        _sendState.value = ProgressState.done;
        Get.back();
        Get.showSnackbar(GetBar(
          message: 'Review Anda telah berhasil dikirim.',
          duration: Duration(seconds: 3),
        ));
      } else {
        _sendState.value = ProgressState.failed;
        Get.dialog(
          AlertDialog(
            content: Text(
                'Pastikan smartphone Anda terhubung ke jaringan internet.'),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('OKE'))
            ],
          ),
          barrierDismissible: false,
        );
      }
    });
  }

  void onFavoritePressed() {
    if (_dbProvider.favoriteBox.containsKey(_id)) {
      _dbProvider.removeRestaurantFromFavorite(_id)
        ..whenComplete(() {
          Get.showSnackbar(
            GetBar(
              message: 'Restoran berhasil dihapus dari favorit.',
              duration: Duration(seconds: 3),
            ),
          );
        });
    } else {
      _dbProvider.addRestaurantToFavorite(Restaurant(
        id: _restaurantDetail.value.id,
        name: _restaurantDetail.value.name,
        pictureId: _restaurantDetail.value.pictureId,
        city: _restaurantDetail.value.city,
        rating: _restaurantDetail.value.rating,
      ))
        ..whenComplete(() {
          Get.showSnackbar(
            GetBar(
              message: 'Restoran berhasil ditambahkan ke favorit.',
              duration: Duration(seconds: 3),
            ),
          );
        });
    }
  }
}
