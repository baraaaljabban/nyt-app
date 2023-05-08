import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/features/articles/data/models/article_most_popular_response.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ArticlesTable {
  @Id()
  int id;
  String publishedDate;
  String title;
  String articleType;
  ArticlesTable({
    this.id = 0,
    required this.publishedDate,
    required this.title,
    required this.articleType,
  });

  factory ArticlesTable.fromModel(
    ArticleModel data,
    ArticleType articleType,
  ) {
    return ArticlesTable(
      publishedDate: data.publishedDate,
      title: data.title,
      articleType: articleType.name,
    );
  }
}
