import 'package:dartz/dartz.dart';
import 'package:nyt/core/enum/articles_type.dart';

import '../../../../core/UseCases/use_cases.dart';
import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

///Use Case For returning list of articles
///needs [MostPopularArticleParams] as params that contains number of days and
///article type you are looking for.
class MostPopularArticleUC extends UseCase<List<Article>, MostPopularArticleParams> {
  final ArticleRepository repository;
  MostPopularArticleUC({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Article>>> call({
    required MostPopularArticleParams params,
  }) async {
    return await repository.getMostPopularArticle(
      type: params.type,
      days: params.days,
      isLoadMore: params.isLoadMore,
    );
  }
}

class MostPopularArticleParams {
  final int days;
  final ArticleType type;
  final bool isLoadMore;
  MostPopularArticleParams({
    required this.days,
    required this.type,
    this.isLoadMore = false,
  });
}
