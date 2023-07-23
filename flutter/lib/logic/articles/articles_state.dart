part of 'articles_cubit.dart';

@immutable
abstract class ArticlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlestLoadingState extends ArticlesState {}

class ArticlestErrorState extends ArticlesState {}

class ArticlestSuccessState extends ArticlesState {}

class ArticlestFilterState extends ArticlesState {
  final String label;

  ArticlestFilterState(this.label);

  @override
  List<Object?> get props => [label];
}

class ArticlesBookMarkState extends ArticlesState {
  final int id;
  final bool isMarked ;

  ArticlesBookMarkState({required this.id,this.isMarked = false});

  @override
  List<Object?> get props => [id,isMarked];
}
