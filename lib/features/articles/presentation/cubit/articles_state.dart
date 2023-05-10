part of 'articles_cubit.dart';

abstract class ArticlesState {
  const ArticlesState();
}

class ArticlesInitialState extends ArticlesState {}

class ArticlesLoadingState extends ArticlesState {}

class ArticlesErrorState extends ArticlesState {
  final String message;
  ArticlesErrorState({
    required this.message,
  });
}

class ArticlesSuccessState extends ArticlesState {
  final List<Article> articles;
  final bool reachedMax;
  ArticlesSuccessState({
    required this.articles,
    this.reachedMax = false,
  });
}
