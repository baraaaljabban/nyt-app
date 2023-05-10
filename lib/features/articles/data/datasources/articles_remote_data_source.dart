import 'dart:convert';

import 'package:nyt/core/Network/http_client.dart';
import 'package:nyt/features/articles/data/models/article_most_popular_response.dart';
import 'package:nyt/features/articles/data/models/article_search_response.dart';

abstract class ArticleRemoteDataSource {
  Future<ArticleMostPopularResponse> getMostPopularArticle({
    required String type,
    required int days,
  });
  Future<ArticleSearchResponse> searchArticle({
    required String query,
  });
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDataSource {
  final HttpClient client;
  ArticleRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<ArticleMostPopularResponse> getMostPopularArticle({required String type, required int days}) async {
    String path = "/mostpopular/v2/$type/$days.json?";

    final response = await client.getData(path: path);
    return ArticleMostPopularResponse.fromJson(
      utf8.decode(response.bodyBytes),
    );
  }

  @override
  Future<ArticleSearchResponse> searchArticle({required String query}) async {
    String path = "/search/v2/articlesearch.json?q=$query&";

    final response = await client.getData(path: path);
    return ArticleSearchResponse.fromJson(
      utf8.decode(response.bodyBytes),
    );
  }
}
