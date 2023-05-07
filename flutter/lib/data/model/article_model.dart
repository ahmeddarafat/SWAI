// import 'dart:developer';

class ArticleModel {
  final String image;
  final String title;
  final String description;
  final String author;
  final String url;
  final String publishedAt;

  ArticleModel({
    required this.image,
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      image: json['urlToImage'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      author: json['author'] as String,
      url: json['url'] as String,
      publishedAt: json['publishedAt'] as String,
    );
  }

  @override
  String toString() => "ArticleModel(title: $title)";
}
