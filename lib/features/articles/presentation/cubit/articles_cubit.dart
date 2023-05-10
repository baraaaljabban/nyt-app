import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt/core/AppStrings/error_strings.dart';
import 'package:nyt/core/enum/articles_type.dart';

import 'package:nyt/features/articles/domain/usecases/search_uc.dart';
import 'package:nyt/features/articles/domain/entities/article.dart';
import 'package:nyt/features/articles/domain/usecases/most_popular.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final SearchArticleUC searchArticleUC;
  final MostPopularArticleUC mostPopularArticleUC;
  var _currentDays = 7;
  late ArticleType _articleType;
  List<Article> articles = [];

  ArticlesCubit({
    required this.searchArticleUC,
    required this.mostPopularArticleUC,
  }) : super(ArticlesInitialState());

  void getArticlesList({required MostPopularArticleParams params}) async {
    _currentDays = params.days;
    _articleType = params.type;
    articles.clear();
    emit(ArticlesLoadingState());
    final result = await mostPopularArticleUC(params: params);
    result.fold(
      (l) {
        emit(ArticlesErrorState(message: l.message));
      },
      (r) {
        _currentDays = 30;
        articles.addAll(r);
        emit(
          ArticlesSuccessState(
            articles: articles,
          ),
        );
      },
    );
  }

  void loadMoreArticlesList() async {
    final result = await mostPopularArticleUC(
        params: MostPopularArticleParams(
      days: _currentDays,
      type: _articleType,
      isLoadMore: true,
    ));
    result.fold(
      (l) {
        emit(ArticlesErrorState(message: l.message));
      },
      (r) {
        final updatedArticles = List<Article>.from(articles)..addAll(r);
        if (updatedArticles.length > articles.length) {
          articles = updatedArticles;
          emit(ArticlesSuccessState(
            articles: articles,
            reachedMax: true,
          ));
        }
      },
    );
  }

  void searchForAnArticle({required String query}) async {
    if (query.trim().isEmpty) {
      emit(ArticlesErrorState(message: EMPTY_QUERY));
    } else {
      emit(ArticlesLoadingState());
      var result = await searchArticleUC(
          params: SearchArticleParams(
        query: query,
      ));
      result.fold(
        (l) {
          emit(ArticlesErrorState(message: l.message));
        },
        (r) {
          emit(ArticlesSuccessState(articles: r));
        },
      );
    }
  }
}
