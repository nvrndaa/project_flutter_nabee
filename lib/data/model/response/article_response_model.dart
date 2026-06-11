class Article {
  final String title;
  final String category;
  final String source;
  final String date;
  final String imageUrl;

  Article({
    required this.title,
    required this.category,
    required this.source,
    required this.date,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    // 1. Ambil nama source dari dalam objek nested 'source'
    String sourceName = json['source']?['name'] ?? 'Unknown Source';

    // 2. Logika penentuan kategori berdasarkan kata kunci di judul
    String titleText = (json['title'] ?? '').toLowerCase();
    String detectedCategory = 'SAVING TIPS'; // Default tag

    if (titleText.contains('economic') ||
        titleText.contains('market') ||
        titleText.contains('global') ||
        titleText.contains('economy')) {
      detectedCategory = 'ECONOMIC GROWTH';
    } else if (titleText.contains('finance') ||
        titleText.contains('literacy') ||
        titleText.contains('smart') ||
        titleText.contains('budget')) {
      detectedCategory = 'SMART FINANCE';
    } else if (titleText.contains('investment') ||
        titleText.contains('stock') ||
        titleText.contains('crypto')) {
      detectedCategory = 'INVESTMENT';
    }

    // 3. Merapikan format tanggal (Contoh: "2026-06-09T..." jadi "Jun 9, 2026")
    String rawDate = json['publishedAt'] ?? '';
    String formattedDate = 'Recent';
    try {
      if (rawDate.isNotEmpty) {
        DateTime dateTime = DateTime.parse(rawDate);
        List<String> months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];
        formattedDate =
            "${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}";
      }
    } catch (e) {
      if (rawDate.length > 10) {
        formattedDate = rawDate.substring(0, 10);
      }
    }

    return Article(
      title: json['title'] ?? 'No Title',
      category: detectedCategory,
      source: sourceName,
      date: formattedDate,
      imageUrl: json['urlToImage'] ??
          'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?q=80&w=500',
    );
  }
}
