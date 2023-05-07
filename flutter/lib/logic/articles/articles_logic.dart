import 'package:google_solution2/data/repository/repository.dart';

import '../../data/model/article_model.dart';

class ArticleLogic {
  final Repository _repo;
  ArticleLogic({
    required Repository repo,
  }) : _repo = repo;

  Future<List<ArticleModel>> getArticles()async{
    return await _repo.getArticles();
  }

}
