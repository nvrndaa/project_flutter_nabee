import 'dart:convert';

class CreateHoneyJarRequestModel {
  final String jarName;
  final int targetAmount;
  final String deadline;

  CreateHoneyJarRequestModel({
    required this.jarName,
    required this.targetAmount,
    required this.deadline,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'jar_name': jarName,
        'target_amount': targetAmount,
        'deadline': deadline,
      };
}

class UpdateHoneyJarRequestModel {
  final String? jarName;
  final int? targetAmount;

  UpdateHoneyJarRequestModel({this.jarName, this.targetAmount});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        if (jarName != null) 'jar_name': jarName,
        if (targetAmount != null) 'target_amount': targetAmount,
      };
}
