class TransactionResponseModel {
  final int id;
  final int honeyJarId;
  final String amount;
  final String createdAt;
  final String updatedAt;

  TransactionResponseModel({
    required this.id,
    required this.honeyJarId,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionResponseModel.fromMap(Map<String, dynamic> json) {
    return TransactionResponseModel(
      id: json['id'],
      honeyJarId: json['honey_jar_id'],
      amount: json['amount'].toString(),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
