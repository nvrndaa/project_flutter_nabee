import 'dart:convert';
import 'package:dartz/dartz.dart'; // Import dartz buat Either, Left, Right
import 'package:http/http.dart' as http;
import 'package:flutter_nabee/core/constants/variable.dart'; // Import file variable global
import '../model/response/article_response.dart';

class ArticleRemoteDatasource {
  Future<Either<String, List<Article>>> fetchArticles() async {
    try {
      // Menggunakan Variables.baseUrl sesuai gaya belajarmu
      // Dan jalurnya disesuaikan jadi '/api/articles' setelah kita ubah di Laravel tadi
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-articles'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> data = responseData['data'] ?? []; 
        
        List<Article> articles = data.map((json) => Article.fromJson(json)).toList();
        
        return Right(articles); // SAKSES: Kembalikan data list artikel di sebelah Right
      } else {
        return const Left('Gagal memuat artikel dari server'); // ERROR: Kembalikan pesan error di sebelah Left
      }
    } catch (e) {
      return Left('Terjadi kesalahan koneksi: $e');
    }
  }
}