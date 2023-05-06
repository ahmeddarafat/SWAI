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
      image: json['image'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      url: json['url'],
      publishedAt: json['publishedAt'],
    );
  }
}
