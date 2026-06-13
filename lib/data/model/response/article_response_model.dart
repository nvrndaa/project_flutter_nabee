class Article {
  final String title;
  final String category;
  final String source;
  final String date;
  final String imageUrl;
  final String url;

  Article({
    required this.title,
    required this.category,
    required this.source,
    required this.date,
    required this.imageUrl,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String sourceName = json['source']?['name'] ?? 'Unknown Source';

    String titleText = (json['title'] ?? '').toLowerCase();
    String detectedCategory = 'SAVING TIPS';

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

    String rawDate = json['publishedAt'] ?? '';
    String formattedDate = 'Recent';
    try {
      if (rawDate.isNotEmpty) {
        DateTime dateTime = DateTime.parse(rawDate);
        List<String> months = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
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
      url: json['url'] ?? '',
    );
  }
}

class ArticleResponseData {
  final List<Article> articles;
  final bool hasMore;

  ArticleResponseData({required this.articles, required this.hasMore});
}
