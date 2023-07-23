import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/article_model.dart';
import '../../data/repository/repository.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final Repository _repo;
  ArticlesCubit({
    required Repository repo,
  })  : _repo = repo,
        super(ArticlesInitial());

  static ArticlesCubit get(BuildContext context) => BlocProvider.of(context);

  List<ArticleModel> _articles = [];
  List<ArticleModel> articlesView = [];
  List<ArticleModel> articlesTrending = [];
  List<ArticleModel> articlesbookmark = [];

  Future<void> getArticles() async {
    emit(ArticlestLoadingState());
    try {
      _articles = await _repo.getArticles();
      articlesView = _articles;
      articlesTrending = _articles.where(
        (article) {
          return article.isTrending;
        },
      ).toList();
      emit(ArticlestSuccessState());
    } catch (e) {
      log(e.toString());
      emit(ArticlestErrorState());
    }
  }

  String label = 'Related';
  void filterByLabel(String label) {
    this.label = label.toLowerCase();
    articlesView = _articles.where((article) {
      if (label == "Related") {
        return true;
      } else {
        return article.label.toLowerCase() == label.toLowerCase();
      }
    }).toList();
    emit(ArticlestFilterState(label));
  }

  void bookmarkArticle(int id) {
    log("id $id");
    for (int i = 0; i < articlesbookmark.length; i++) {
      if (articlesbookmark[i].id == id) {
        articlesbookmark[i].isMarked = false;
        articlesbookmark.removeAt(i);
        emit(ArticlesBookMarkState(id: id, isMarked: false));
        return;
      }
    }
    for (int i = 0; i < _articles.length; i++) {
      if (_articles[i].id == id) {
        articlesbookmark.add(_articles[i]);
        _articles[i].isMarked = true;
        emit(ArticlesBookMarkState(id: id, isMarked: true));
        return;
      }
    }
  }
}
