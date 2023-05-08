import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/features/articles/data/datasources/local/tables/articles_table.dart';
import 'package:nyt/features/articles/data/models/article_most_popular_response.dart';
import 'package:objectbox/objectbox.dart';

abstract class ArticlesLocalDataSource {
  void cacheArticles({
    required List<ArticleModel> articlesModel,
    required ArticleType articleType,
  });
  List<ArticleModel> getCacheArticles({required ArticleType articleType});
  List<ArticleModel> searchLocalArticles({required String query});
}

class ArticlesLocalDataSourceImpl extends ArticlesLocalDataSource {
  final Store store;
  ArticlesLocalDataSourceImpl({
    required this.store,
  });

  @override
  void cacheArticles({
    required List<ArticleModel> articlesModel,
    required ArticleType articleType,
  }) {
    try {
      var articlesToBeDeleted =
          store.box<ArticlesTable>().getAll().where((element) => element.articleType == articleType.name).map((e) => e.id).toList();
      store.box<ArticlesTable>().removeMany(articlesToBeDeleted);

      var articles = articlesModel
          .map(
            (e) => ArticlesTable.fromModel(e, articleType),
          )
          .toList();

      store.box<ArticlesTable>().putMany(articles);
    } catch (_) {}
  }

  @override
  List<ArticleModel> getCacheArticles({required ArticleType articleType}) {
    try {
      var localArticles = store.box<ArticlesTable>().getAll().where(
            (element) => element.articleType == articleType.name,
          );
      var articles = localArticles
          .map(
            (e) => ArticleModel.fromTable(e),
          )
          .toList();

      return articles;
    } catch (_) {
      return [];
    }
  }

  @override
  List<ArticleModel> searchLocalArticles({required String query}) {
    try {
      var localArticles = store.box<ArticlesTable>().getAll().where(
            (element) => element.title.contains(query),
          );
      var articles = localArticles
          .map(
            (e) => ArticleModel.fromTable(e),
          )
          .toList();

      return articles;
    } catch (e) {
      return [];
    }
  }
}
