import 'package:hive/hive.dart';

part 'restaurant.g.dart';

@HiveType(typeId: 0)
class Restaurant {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  final String description;
  @HiveField(2)
  final String pictureId;
  @HiveField(3)
  final String city;
  @HiveField(4)
  final num rating;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'],
    );
  }
}
