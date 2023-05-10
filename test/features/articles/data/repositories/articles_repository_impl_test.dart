// ignore_for_file: avoid_returning_null_for_void

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/core/error/exceptions.dart';
import 'package:nyt/core/error/failures.dart';
import 'package:nyt/features/articles/data/models/article_most_popular_response.dart';
import 'package:nyt/features/articles/data/repositories/articles_repository_impl.dart';
import 'package:nyt/features/articles/domain/repositories/article_repository.dart';

import '../../../mocks.mocks.dart';

void main() {
  late MockArticleRemoteDataSource remoteDataSource;
  late MockArticlesLocalDataSource localDataSource;
  late ArticleRepository articleRepository;
  var articleType = ArticleType.emailed;
  var artical1 = ArticleModel(publishedDate: 'publishedDate', title: 'title');
  var artical2 = ArticleModel(publishedDate: 'publishedDate', title: 'title');
  List<ArticleModel> articles = [artical1, artical2];
  var response = ArticleMostPopularResponse(results: articles);
  var days = 7;
  var serverException = ServerErrorException(body: 'body');
  final failure = UnhandledFailure(className: 'ArticleRepositoryImpl', message: 'Test failure');
  var query = 'query';
  setUp(() {
    remoteDataSource = MockArticleRemoteDataSource();
    localDataSource = MockArticlesLocalDataSource();
    articleRepository = ArticleRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );
    when(localDataSource.getCacheArticles(articleType: articleType)).thenAnswer((_) => articles);
    when(localDataSource.cacheArticles(articleType: articleType, articlesModel: articles)).thenAnswer((_) => null);
    when(remoteDataSource.getMostPopularArticle(type: articleType.name, days: days)).thenAnswer((_) async => response);
    // when(remoteDataSource.searchArticle(query: query)).thenAnswer((_) async => response.results);
    when(localDataSource.searchLocalArticles(query: query)).thenAnswer((_) => response.results);
  });
  group('Articles Repository get articles ', () {
    test('getting success list of articles', () async {
      var response = await articleRepository.getMostPopularArticle(type: articleType, days: days, isLoadMore: false);
      expect(response, Right(articles));
    });
    test('getting success list of articles even if there is issue in caching in local DB', () async {
      var response = await articleRepository.getMostPopularArticle(type: articleType, days: days, isLoadMore: false);
      when(localDataSource.cacheArticles(articleType: articleType, articlesModel: articles)).thenThrow((_) => LocalDataBaseException());

      expect(response, Right(articles));
    });

    test('getting success list of articles even if there is issue in caching in local DB', () async {
      var response = await articleRepository.getMostPopularArticle(type: articleType, days: days, isLoadMore: false);
      when(localDataSource.cacheArticles(articleType: articleType, articlesModel: articles)).thenAnswer((_) => any);

      expect(response, Right(articles));
    });

    test('getting success list of articles even if there is issue in caching in local DB', () async {
      when(remoteDataSource.getMostPopularArticle(type: articleType.name, days: days)).thenThrow(
        (_) => serverException,
      );
      var response = await articleRepository.getMostPopularArticle(type: articleType, days: days, isLoadMore: false);
      expect(response, Left(failure));
    });

    test('articles should be retrieved from local DB if the Exception is SocketException', () async {
      when(remoteDataSource.getMostPopularArticle(type: articleType.name, days: days)).thenAnswer(
        (_) => throw const SocketException(''),
      );
      var response = await articleRepository.getMostPopularArticle(type: articleType, days: days, isLoadMore: false);
      expect(response, Right(articles));
    });
  });

  group('Articles Repository search for an articles ', () {
    test('getting success list of articles', () async {
      var response = await articleRepository.searchArticle(query: query);
      expect(response, Right(articles));
    });
    test('getting success list of articles even if there is issue in caching in local DB', () async {
      var response = await articleRepository.searchArticle(query: query);
      when(localDataSource.cacheArticles(articleType: articleType, articlesModel: articles)).thenThrow((_) => LocalDataBaseException());

      expect(response, Right(articles));
    });

    test('getting success list of articles even if there is issue in caching in local DB', () async {
      var response = await articleRepository.searchArticle(query: query);
      when(localDataSource.cacheArticles(articleType: articleType, articlesModel: articles)).thenAnswer((_) => any);

      expect(response, Right(articles));
    });

    test('getting success list of articles even if there is issue in caching in local DB', () async {
      when(remoteDataSource.searchArticle(query: query)).thenThrow(
        (_) => serverException,
      );
      var response = await articleRepository.searchArticle(query: query);
      expect(response, Left(failure));
    });

    test('articles should be retrieved from local DB if the Exception is SocketException', () async {
      when(remoteDataSource.searchArticle(query: query)).thenAnswer(
        (_) => throw const SocketException(''),
      );
      var response = await articleRepository.searchArticle(query: query);
      expect(response, Right(articles));
    });
  });
}
