import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  String? foodName;
  String? price;
  String? url;

  Food({
    this.foodName,
    this.price,
    this.url,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        foodName: json["foodName"],
        price: json["price"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "foodName": foodName,
        "price": price,
        "url": url,
      };
}
