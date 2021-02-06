import 'category.dart';
import 'menu.dart';
import 'review.dart';

class DetailRestaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menu menu;
  num rating;
  List<Review> customerReviews;

  DetailRestaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menu,
    this.rating,
    this.customerReviews,
  });

  DetailRestaurant.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.description = json['description'];
    this.city = json['city'];
    this.address = json['address'];
    this.pictureId = json['pictureId'];
    this.categories =
        List.from(json['categories']).map((e) => Category.fromJson(e)).toList();
    this.menu = Menu.fromJson(json['menus']);
    this.rating = json['rating'];
    this.customerReviews = List.from(json['customerReviews'])
        .map((e) => Review.fromJson(e))
        .toList();
  }
}
