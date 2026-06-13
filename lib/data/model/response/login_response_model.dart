import 'dart:convert';

class LoginResponseModel {
  final User? user;
  final String? token;

  LoginResponseModel({this.user, this.token});

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(user: User.fromMap(json["user"]), token: json["token"]);

  Map<String, dynamic> toMap() => {"user": user?.toMap(), "token": token};
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? avatar;
  final dynamic emailVerifiedAt;
  final dynamic createdAt;
  final dynamic updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
