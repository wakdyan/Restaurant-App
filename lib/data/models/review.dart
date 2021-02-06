class Review {
  String date;
  String name;
  String review;

  Review({id, name, review});

  Review.fromJson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.name = json['name'];
    this.review = json['review'];
  }
}
