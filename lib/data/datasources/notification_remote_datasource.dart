import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nabee/core/constants/variable.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/model/response/notification_log_response_model.dart';

class NotificationLogRemoteDatasource {
  Future<Either<String, List<NotificationLogResponseModel>>>
      fetchNotificationLogs() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/notification-logs'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data['data'] ?? [];
        final logs = list
            .map((e) => NotificationLogResponseModel.fromMap(e))
            .toList();
        return Right(logs);
      } else {
        return Left('Gagal mengambil notifikasi');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }
}
