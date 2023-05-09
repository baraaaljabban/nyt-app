import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:nyt/core/Network/network_info.dart';
import 'package:nyt/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:nyt/features/articles/data/datasources/local/articles_local_data_source.dart';
import 'package:nyt/features/articles/domain/repositories/article_repository.dart';

@GenerateMocks([
  ArticleRepository,
  Location,
  ConnectionChecker,
  InternetConnectionCheckerPlus,
  ArticlesLocalDataSource,
  ArticleRemoteDataSource,
])
void main() {}
