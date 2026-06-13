import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nabee/core/constants/variable.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/model/request/transaction_request_model.dart';
import 'package:flutter_nabee/data/model/response/transaction_response_model.dart';

class TransactionRemoteDatasource {
  Future<Either<String, List<TransactionResponseModel>>>
      fetchTransactions() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-transactions'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data['data'] ?? [];
        final transactions = list
            .map((e) => TransactionResponseModel.fromMap(e))
            .toList();
        return Right(transactions);
      } else {
        return Left('Gagal mengambil data transaksi');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }

  Future<Either<String, TransactionResponseModel>> createTransaction(
    CreateTransactionRequestModel request,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/api-transactions'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: request.toJson(),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Right(TransactionResponseModel.fromMap(data['data']));
      } else {
        return Left('Gagal menambahkan transaksi');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }
}
