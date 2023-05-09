import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/features/articles/domain/entities/article.dart';

class SearchControllerArgument {
  final ArticleType articleType;
  final String searchQuery;
  SearchControllerArgument({
    required this.articleType,
    required this.searchQuery,
  });
}

class ArticleListControllerArguments {
  final List<Article> articles;
  ArticleListControllerArguments({
    required this.articles,
  });
}
