import 'package:dartz/dartz.dart';
import 'package:nyt/core/enum/articles_type.dart';

import '../../../../core/error/failures.dart';
import '../entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getMostPopularArticle({
    required ArticleType type,
    required int days,
  });
  Future<Either<Failure, List<Article>>> searchArticle({
    required String query,
  });
}
