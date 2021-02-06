import 'package:get/get_connect/connect.dart';

class ApiProvider extends GetConnect {
  final _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<Response> getRestaurantList() => get(_baseUrl + '/list');

  Future<Response> getRestaurantDetail(String id) =>
      get(_baseUrl + '/detail/$id');

  Future<Response> searchRestaurant(String restaurantName) {
    var parsed = Uri.parse(restaurantName);
    return get(_baseUrl + '/search?q=$parsed');
  }

  Future<Response> postReview(Map<String, String> review) {
    return post(_baseUrl + '/review', review, headers: {
      'Content-Type': 'application/json',
      'X-Auth-Token': 'YOUR AUTH TOKEN',
    });
  }
}
