import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nyt/core/AppStrings/error_strings.dart';
import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/core/error/failures.dart';
import 'package:nyt/features/articles/domain/entities/article.dart';
import 'package:nyt/features/articles/domain/usecases/most_popular.dart';
import 'package:nyt/features/articles/domain/usecases/search_uc.dart';
import 'package:nyt/features/articles/presentation/cubit/articles_cubit.dart';

import 'mocks.mocks.dart';

void main() {
  late MostPopularArticleUC mostPopularArticleUC;
  late MockArticleRepository mockArticleRepository;
  late ArticlesCubit articlesCubit;
  late SearchArticleUC searchArticleUC;
  var type = ArticleType.viewed;
  var days = 7;
  MostPopularArticleParams params = MostPopularArticleParams(days: days, type: type);
  List<Article> expectedArticles = [Article(publishedDate: 'publishedDate', title: 'title')];
  var fail = ServerUnavailableFailure(message: 'fail');
  var query = 'example';
  setUp(() {
    // Initialize the necessary objects
    mockArticleRepository = MockArticleRepository();
    mostPopularArticleUC = MostPopularArticleUC(repository: mockArticleRepository);
    searchArticleUC = SearchArticleUC(repository: mockArticleRepository);

    articlesCubit = ArticlesCubit(searchArticleUC: searchArticleUC, mostPopularArticleUC: mostPopularArticleUC);
    when(mockArticleRepository.getMostPopularArticle(type: ArticleType.viewed, days: 7)).thenAnswer((realInvocation) async => right([]));
    when(searchArticleUC(params: SearchArticleParams(query: query))).thenAnswer((_) async => Right([]));
  });

  group('ArticlesCubit', () {
    // Test the getArticlesList method
    blocTest<ArticlesCubit, ArticlesState>(
      'emits [ArticlesLoadingState, ArticlesSuccessState] when getArticlesList is called successfully',
      build: () {
        when(mockArticleRepository.getMostPopularArticle(type: ArticleType.viewed, days: 7))
            .thenAnswer((realInvocation) async => right(expectedArticles));
        return articlesCubit;
      },
      act: (cubit) => cubit.getArticlesList(params: params),
      verify: (_) {
        verify(mostPopularArticleUC(params: params)).called(1);
      },
      expect: () => [
        isA<ArticlesLoadingState>(),
        isA<ArticlesSuccessState>().having((p0) => p0.articles, 'articles', equals(expectedArticles)),
      ],
    );

    blocTest<ArticlesCubit, ArticlesState>(
      'emits [MyState] when MyEvent is added.',
      build: () => articlesCubit,
      act: (bloc) => articlesCubit.getArticlesList(params: params),
      expect: () => [isA<ArticlesLoadingState>(), isA<ArticlesSuccessState>()],
    );

    blocTest<ArticlesCubit, ArticlesState>(
      'emits [ArticlesLoadingState, ArticlesErrorState] when getArticlesList encounters an error',
      build: () => articlesCubit,
      act: (cubit) {
        when(mockArticleRepository.getMostPopularArticle(type: ArticleType.viewed, days: 7))
            .thenAnswer((realInvocation) async => left(fail));

        cubit.getArticlesList(params: params);
      },
      verify: (_) {
        verify(mostPopularArticleUC(params: params)).called(1);
      },
      expect: () => [
        isA<ArticlesLoadingState>(),
        isA<ArticlesErrorState>().having((p0) => p0.message, 'error message', equals(fail.message)),
      ],
    );

// Test case for handling an error in searchForAnArticle
    blocTest<ArticlesCubit, ArticlesState>(
      'emits [ArticlesLoadingState, ArticlesErrorState] when searchForAnArticle encounters an error',
      build: () => articlesCubit,
      act: (cubit) {
        when(searchArticleUC(params: SearchArticleParams(query: query))).thenAnswer((_) async => Left(fail));

        cubit.searchForAnArticle(query: query);
      },
      verify: (_) {
        verify(searchArticleUC(params: SearchArticleParams(query: query))).called(1);
      },
      expect: () => [
        isA<ArticlesLoadingState>(),
        isA<ArticlesErrorState>().having((p0) => p0.message, 'error message', equals(fail.message)),
      ],
    );

// Test case for handling an empty query in searchForAnArticle
    blocTest<ArticlesCubit, ArticlesState>(
      'emits [ArticlesErrorState] when searchForAnArticle is called with an empty query',
      build: () => articlesCubit,
      act: (cubit) => cubit.searchForAnArticle(query: ''),
      expect: () => [
        isA<ArticlesErrorState>().having((p0) => p0.message, 'error message', equals(EMPTY_QUERY)),
      ],
    );

// Test case for handling a successful searchForAnArticle with no articles found
    blocTest<ArticlesCubit, ArticlesState>(
      'emits [ArticlesLoadingState, ArticlesSuccessState] with empty article list when searchForAnArticle finds no articles',
      build: () => articlesCubit,
      act: (cubit) async {
        cubit.searchForAnArticle(query: query);
      },
      verify: (_) {
        verify(searchArticleUC(params: SearchArticleParams(query: query))).called(1);
      },
      expect: () => [
        isA<ArticlesLoadingState>(),
        isA<ArticlesSuccessState>().having((p0) => p0.articles.length, 'number of articles is 0', equals(0)),
      ],
    );
  });
}
