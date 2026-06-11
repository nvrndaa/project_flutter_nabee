//tempat ngehandling public function
import 'package:dartz/dartz.dart';
import 'package:flutter_nabee/core/constants/variable.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/model/request/login_request_model.dart';
import 'package:flutter_nabee/data/model/request/register_request_model.dart';
import 'package:flutter_nabee/data/model/response/login_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  // klo kiri itu error disini dibikin klo error bakal jadi string
  // kalo kanan itu berhasil, yaitu bakal ngeluarin loginresponse
  Future<Either<String, LoginResponseModel>> login(
    LoginRequestModel dataLogin,
  ) async {
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: dataLogin.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, LoginResponseModel>> register(
    RegisterRequestModel dataRegister,
  ) async {
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: dataRegister.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // untuk logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
        // data org yg diambil disimpen di outhdata
      },
    );

    if (response.statusCode == 200) {
      return Right('logout berhasil');
    } else {
      return Left(response.body);
    }
  }
}
