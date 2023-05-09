import 'package:dartz/dartz.dart';
import 'package:nyt/core/UseCases/use_cases.dart';
import 'package:nyt/core/error/failures.dart';
import 'package:nyt/features/articles/domain/entities/article.dart';
import 'package:nyt/features/articles/domain/repositories/article_repository.dart';

class SearchArticleUC extends UseCase<List<Article>, SearchArticleParams> {
  final ArticleRepository repository;
  SearchArticleUC({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Article>>> call({
    required SearchArticleParams params,
  }) async {
    return await repository.searchArticle(query: params.query);
  }
}

class SearchArticleParams {
  final String query;

  SearchArticleParams({
    required this.query,
  });
}
