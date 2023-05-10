import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nyt/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:nyt/features/articles/data/models/article_most_popular_response.dart';

import '../../../mocks.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  group('ArticleRemoteDataSource', () async {
    late ArticleRemoteDataSource remoteDataSource;
    late MockHttpClient mockHttpClient;
    var article1 = ArticleModel(publishedDate: 'publishedDate', title: 'title');
    var article2 = ArticleModel(publishedDate: 'publishedDate', title: 'title');
    List<ArticleModel> articles = [article1, article2];
    var type = 'type';
    var days = 7;
    var jsonContent = await rootBundle.loadString('most_popular.json');

    setUp(() {
      mockHttpClient = MockHttpClient();
      remoteDataSource = ArticleRemoteDataSourceImpl(
        client: mockHttpClient,
      );
    });

    group('getMostPopularArticle', () {
      test('returns ArticleMostPopularResponse when successful', () async {
        final expectedResponse = ArticleMostPopularResponse(
          results: articles,
        );
        when(mockHttpClient.getData(path: '/mostpopular/v2/$type/$days.json?')).thenAnswer((_) async => http.Response(
              jsonContent,
              200,
            ));

        final result = await remoteDataSource.getMostPopularArticle(type: type, days: days);

        expect(result, equals(expectedResponse));
        verify(mockHttpClient.getData(path: '/mostpopular/v2/$type/$days.json?')).called(1);
      });
    });

    // group('searchArticle', () {
    //   test('returns ArticleSearchResponse when successful', () async {
    //     // Arrange
    //     final query = 'query';
    //     final expectedResponse = ArticleSearchResponse( );
    //     when(mockHttpClient.getData(any)).thenAnswer((_) async => /* mock http response */);

    //     // Act
    //     final result = await remoteDataSource.searchArticle(query: query);

    //     // Assert
    //     expect(result, equals(expectedResponse));
    //     verify(mockHttpClient.getData(path:'/search/v2/articlesearch.json?q=$query&')).called(1);
    //   });
    // });
  });
}
