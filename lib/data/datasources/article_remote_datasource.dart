import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nabee/core/constants/variable.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import '../model/response/article_response_model.dart';

class ArticleRemoteDatasource {
  Future<Either<String, ArticleResponseData>> fetchArticles({int page = 1}) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-articles?page=$page'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> data = responseData['data'] ?? [];
        bool hasMore = responseData['has_more'] ?? false;

        List<Article> articles = data.map((json) => Article.fromJson(json)).toList();

        return Right(ArticleResponseData(articles: articles, hasMore: hasMore));
      } else {
        return const Left('Gagal memuat artikel dari server');
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }
}
