import 'menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureUrl;
  final String city;
  final num rating;
  final Menu menu;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureUrl,
    this.city,
    this.rating,
    this.menu,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureUrl: json['pictureId'],
      city: json['city'],
      rating: json['rating'],
      menu: Menu.fromJson(json['menus']),
    );
  }
}
