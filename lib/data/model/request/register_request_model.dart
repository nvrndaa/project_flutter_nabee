import 'dart:convert';

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
