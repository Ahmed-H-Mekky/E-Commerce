class Modelproduct {
  final String title;
  final double price;
  final String description;
  final String category;
  final Rating? rating;
  final String image;
  Modelproduct({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });
  factory Modelproduct.fromjson(json) {
    return Modelproduct(
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['Rating'] != null ? Rating.fromjson(json['Rating']) : null,
    );
  }
}

class Rating {
  final String rate;
  final String count;
  Rating({required this.rate, required this.count});
  factory Rating.fromjson(json) {
    return Rating(rate: json['rate'], count: json['count']);
  }
}
