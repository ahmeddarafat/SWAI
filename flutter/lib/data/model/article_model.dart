// import 'dart:developer';

class ArticleModel {
  final int id;
  final String image;
  final String title;
  final String description;
  final String author;
  final String publishedAt;
  final String label;
  final bool isTrending;
  bool isMarked;

  ArticleModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.author,
    required this.publishedAt,
    required this.label,
    required this.isTrending,
    this.isMarked = false,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json["id"] as int,
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      author: json['author'] as String,
      publishedAt: json['publishedAt'] as String,
      label: json['label'] as String,
      isTrending: json['isTrending'] as bool,
    );
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    return super == other && other is ArticleModel && other.id == id;
  }

  @override
  String toString() => "ArticleModel(id: $id)";
}
