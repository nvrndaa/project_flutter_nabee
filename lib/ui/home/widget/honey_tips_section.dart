import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/data/model/response/article_response_model.dart';
import 'package:flutter_nabee/data/datasources/article_remote_datasource.dart';

class HoneyTipsSection extends StatefulWidget {
  const HoneyTipsSection({super.key});

  @override
  State<HoneyTipsSection> createState() => _HoneyTipsSectionState();
}

class _HoneyTipsSectionState extends State<HoneyTipsSection> {
  final ArticleRemoteDatasource _articleDatasource = ArticleRemoteDatasource();

  // Variabel penampung state data async dari dartz remote datasource
  late Future<Either<String, List<Article>>> _articleFuture;

  @override
  void initState() {
    super.initState();
    // Di-load sekali saja di sini biar aman dan hemat kuota request API
    _articleFuture = _articleDatasource.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul Section "Honey tips"
        const Text(
          "Honey tips",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.brownText,
          ),
        ),
        const SizedBox(height: 12),

        // FutureBuilder menggunakan tipe data Either<String, List<Article>>
        FutureBuilder<Either<String, List<Article>>>(
          future: _articleFuture,
          builder: (context, snapshot) {
            // 1. Kondisi pas data lagi loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.orange),
                ),
              );
            }

            // 2. Kondisi pas snapshot mengalami error bawaan sistem atau data null
            if (snapshot.hasError || !snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Gagal memuat tips. Periksa koneksi ke server Laravel.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              );
            }

            // 3. Fungsi .fold() dari dartz untuk memisahkan Left dan Right
            return snapshot.data!.fold(
              (errorMessage) {
                // === JIKA LEFT (Terjadi Error String dari backend/koneksi) ===
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                );
              },
              (articles) {
                // === JIKA RIGHT (Sukses dapet data List<Article>) ===
                if (articles.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text('Belum ada tips buat hari ini.')),
                  );
                }

                // Tampilan daftar artikel jika berhasil dimuat
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.softYellow,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          // --- KIRI: Gambar Artikel ---
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(
                              article.imageUrl,
                              width: 95,
                              height: 95,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 95,
                                  height: 95,
                                  color: Colors.amber[100],
                                  child: const Icon(Icons.broken_image,
                                      color: AppColors.orange),
                                );
                              },
                            ),
                          ),

                          // --- KANAN: Detail Teks ---
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Badge Kategori Kuning
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      article.category,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),

                                  // Judul Artikel
                                  Text(
                                    article.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  // Nama Media/Source Berita
                                  Text(
                                    article.source,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.black54),
                                  ),

                                  // Tanggal Rilis Artikel
                                  Text(
                                    article.date,
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
