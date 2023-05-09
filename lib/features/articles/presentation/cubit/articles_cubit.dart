import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt/core/AppStrings/error_strings.dart';

import 'package:nyt/features/articles/domain/usecases/search_uc.dart';
import 'package:nyt/features/articles/domain/entities/article.dart';
import 'package:nyt/features/articles/domain/usecases/most_popular.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final SearchArticleUC searchArticleUC;
  final MostPopularArticleUC mostPopularArticleUC;

  ArticlesCubit({
    required this.searchArticleUC,
    required this.mostPopularArticleUC,
  }) : super(ArticlesInitialState());

  void getArticlesList({required MostPopularArticleParams params}) async {
    emit(ArticlesLoadingState());
    final result = await mostPopularArticleUC(params: params);
    result.fold(
      (l) {
        emit(ArticlesErrorState(message: l.message));
      },
      (r) {
        emit(
          ArticlesSuccessState(
            articles: r,
          ),
        );
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
