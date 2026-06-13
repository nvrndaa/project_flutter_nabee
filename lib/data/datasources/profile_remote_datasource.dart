import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nabee/core/constants/variable.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/model/response/login_response_model.dart';

class ProfileRemoteDatasource {
  Future<Either<String, User>> updateAvatar(String imagePath) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Variable.baseUrl}/api/api/profile/update'),
      );
      request.headers['Authorization'] = 'Bearer ${authData.token}';
      request.files
          .add(await http.MultipartFile.fromPath('avatar', imagePath));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final user = User.fromMap(json['user']);
        if (user.avatar != null) {
          String avatarUrl = user.avatar!;
          if (!avatarUrl.startsWith('http')) {
            avatarUrl = '${Variable.baseUrl}/$avatarUrl';
          }
          await AuthLocalDatasource().saveAvatarUrl(avatarUrl);
        }
        return Right(user);
      } else {
        final body = response.body;
        final snippet = body.length > 200 ? body.substring(0, 200) : body;
        String msg = 'Gagal (${response.statusCode}): $snippet';
        try {
          final json = jsonDecode(body);
          if (json['message'] != null) msg = json['message'];
          if (json['errors'] != null) msg = json['errors'].toString();
        } catch (_) {}
        return Left(msg);
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }
}
