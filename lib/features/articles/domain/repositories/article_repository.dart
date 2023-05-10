import 'package:dartz/dartz.dart';
import 'package:nyt/core/enum/articles_type.dart';

import '../../../../core/error/failures.dart';
import '../entities/article.dart';

abstract class ArticleRepository {
  /// get the most Popular articles : takes 2 params `ArticleType` [type]
  /// and number of [days]
  /// return `List<Article>` if success
  /// or `Failure` object when fails
  Future<Either<Failure, List<Article>>> getMostPopularArticle({
    required ArticleType type,
    required int days,
    required bool isLoadMore,
  });

  /// search for an article using [query]
  /// return `List<Article>` if success
  /// or `Failure` object when fails
  Future<Either<Failure, List<Article>>> searchArticle({
    required String query,
  });
}
