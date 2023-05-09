// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:nyt/features/articles/data/datasources/local/tables/articles_table.dart';
import 'package:nyt/features/articles/domain/entities/article.dart';

class ArticleMostPopularResponse {
  List<ArticleModel> results;
  ArticleMostPopularResponse({
    required this.results,
  });

  factory ArticleMostPopularResponse.fromMap(Map<String, dynamic> map) {
    return ArticleMostPopularResponse(
      results: List<ArticleModel>.from(map['results'].map((x) => ArticleModel.fromMap(x))),
    );
  }

  factory ArticleMostPopularResponse.fromJson(String source) => ArticleMostPopularResponse.fromMap(json.decode(source));
}

class ArticleModel extends Article {
  String publishedDate;
  String title;

  ArticleModel({
    required this.publishedDate,
    required this.title,
  }) : super(
          title: title,
          publishedDate: publishedDate,
        );

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      publishedDate: map['published_date'] != null ? map['published_date'] as String : "",
      title: map['title'] != null ? map['title'] as String : "",
    );
  }

  factory ArticleModel.fromJson(String source) => ArticleModel.fromMap(json.decode(source));

  factory ArticleModel.fromTable(ArticlesTable table) => ArticleModel(
        title: table.title,
        publishedDate: table.publishedDate,
      );
}
