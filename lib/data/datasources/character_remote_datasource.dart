import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nabee/core/constants/variable.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/model/response/character_response_model.dart';

class CharacterRemoteDatasource {
  Future<Either<String, CharacterResponseModel>> fetchCharacter() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/character'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(CharacterResponseModel.fromMap(data['data']));
      } else {
        return Left('Gagal mengambil data karakter');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }

  Future<Either<String, CharacterResponseModel>> updateName(String name) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/character/name'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: json.encode({'name': name}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(CharacterResponseModel.fromMap(data['data']));
      } else {
        return Left('Gagal mengupdate nama karakter');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }
}
