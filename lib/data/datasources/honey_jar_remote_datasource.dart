import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nabee/core/constants/variable.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/model/request/honey_jar_request_model.dart';
import 'package:flutter_nabee/data/model/response/honey_jar_response_model.dart';

class HoneyJarRemoteDatasource {
  Future<Either<String, List<HoneyJarResponseModel>>> fetchHoneyJars() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-honey-jars'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data['data'] ?? [];
        final jars =
            list.map((e) => HoneyJarResponseModel.fromMap(e)).toList();
        return Right(jars);
      } else {
        return Left('Gagal mengambil data celengan');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }

  Future<Either<String, HoneyJarResponseModel>> createHoneyJar(
    CreateHoneyJarRequestModel request,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/api-honey-jars'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(HoneyJarResponseModel.fromMap(data['data']));
      } else {
        return Left('Gagal membuat celengan baru');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }

  Future<Either<String, HoneyJarResponseModel>> showHoneyJar(int id) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-honey-jars/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(HoneyJarResponseModel.fromMap(data['data']));
      } else {
        return Left('Gagal menemukan celengan');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }

  Future<Either<String, HoneyJarResponseModel>> updateHoneyJar(
    int id,
    UpdateHoneyJarRequestModel request,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.put(
        Uri.parse('${Variable.baseUrl}/api/api-honey-jars/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(HoneyJarResponseModel.fromMap(data['data']));
      } else {
        return Left('Gagal mengupdate celengan');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }

  Future<Either<String, String>> deleteHoneyJar(int id) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.delete(
        Uri.parse('${Variable.baseUrl}/api/api-honey-jars/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        return Right('Berhasil menghapus celengan');
      } else {
        return Left('Gagal menghapus celengan');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }
}
