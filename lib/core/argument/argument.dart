import 'package:nyt/core/enum/articles_type.dart';

class ArticleListControllerArguments {
  final bool isFromSearch;
  final ArticleType? articleType;
  final int? days;
  final String? searchQuery;
  ArticleListControllerArguments({
    required this.isFromSearch,
    this.articleType,
    this.days,
    this.searchQuery,
  });
}
