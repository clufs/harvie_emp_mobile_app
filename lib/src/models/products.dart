import 'dart:convert';

class Product {
  int id;
  String title;
  dynamic priceToSell;

  Product({required this.id, required this.title, required this.priceToSell});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      priceToSell: json['priceToSell'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'priceToSell': priceToSell,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      priceToSell: map['priceToSell'],
    );
  }
}

List<Product> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
