class Category {
  String name;

  Category(name);

  Category.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
  }
}
