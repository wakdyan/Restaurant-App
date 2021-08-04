class Menu {
  final List<String> foods;
  final List<String> drinks;

  Menu({this.foods, this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: List.from(json['foods']).map<String>((e) => e['name']).toList(),
      drinks: List.from(json['drinks']).map<String>((e) => e['name']).toList(),
    );
  }
}
