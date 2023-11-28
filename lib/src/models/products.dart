import 'dart:convert';

class Product {
  int id;
  String title;
  int priceToSell;
  String category;

  Product({
    required this.id,
    required this.title,
    required this.priceToSell,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      priceToSell: json['priceToSell'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'priceToSell': priceToSell,
      'category': category,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      priceToSell: map['priceToSell'],
      category: map['category'],
    );
  }
}

List<Product> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
