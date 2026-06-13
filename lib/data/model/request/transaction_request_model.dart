import 'dart:convert';

class CreateTransactionRequestModel {
  final int honeyJarId;
  final int amount;

  CreateTransactionRequestModel({
    required this.honeyJarId,
    required this.amount,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'honey_jar_id': honeyJarId,
        'amount': amount,
      };
}
