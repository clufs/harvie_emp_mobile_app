import 'dart:convert';

class Cart {
  Cart({
    required this.cart,
  });

  List<CartItem> cart = [];

  factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        cart: List<CartItem>.from(
            json["products"].map((x) => CartItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(cart.map((x) => x.toMap())),
      };
}

class CartItem {
  CartItem({
    required this.name,
    required this.id,
    required this.cant,
    required this.price,
  });

  String name;
  String id;
  int cant;
  int price;

  factory CartItem.fromJson(String str) => CartItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
      id: json["id"],
      name: json["name"],
      cant: json["cant"],
      price: json["price"]);

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "cant": cant, "price": price};
}
