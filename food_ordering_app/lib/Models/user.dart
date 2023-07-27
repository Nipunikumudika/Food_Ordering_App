import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? name;
  String? email;
  String? country;
  String? catergory;

  User({
    this.id,
    this.name,
    this.email,
    this.country,
    this.catergory,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        country: json["country"],
        catergory: json["catergory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "country": country,
        "catergory": catergory,
      };
}
