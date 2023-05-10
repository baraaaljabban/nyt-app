import 'dart:io';

import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/core/error/error_handler.dart';
import 'package:nyt/core/error/exceptions.dart';
import 'package:nyt/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:nyt/features/articles/data/datasources/local/articles_local_data_source.dart';
import 'package:nyt/features/articles/domain/entities/article.dart';
import 'package:nyt/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nyt/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository with ErrorHandler {
  final ArticlesLocalDataSource localDataSource;
  final ArticleRemoteDataSource remoteDataSource;
  ArticleRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Article>>> getMostPopularArticle({required ArticleType type, required int days}) async {
    try {
      var remoteArticles = await remoteDataSource.getMostPopularArticle(
        days: days,
        type: type.name,
      );
      localDataSource.cacheArticles(articleType: type, articlesModel: remoteArticles.results);
      return Right(remoteArticles.results);
    } catch (e) {
      if (e is SocketException || e is ConnectionUnavailableException) {
        var articlesFromTable = localDataSource.getCacheArticles(articleType: type);
        return Right(articlesFromTable);
      } else if (e is Exception) {
        return Left(mapCommonExceptionToFailure(e));
      }
      return Left(UnhandledFailure(className: 'ArticleRepositoryImpl', message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchArticle({required String query}) async {
    try {
      var remoteArticles = await remoteDataSource.searchArticle(query: query);
      return Right(remoteArticles.response.docs);
    } catch (e) {
      if (e is SocketException || e is ConnectionUnavailableException) {
        var articlesFromTable = localDataSource.searchLocalArticles(
          query: query,
        );
        return Right(articlesFromTable);
      } else if (e is Exception) {
        return Left(mapCommonExceptionToFailure(e));
      }
      return Left(UnhandledFailure(className: 'ArticleRepositoryImpl', message: e.toString()));
    }
  }
}
