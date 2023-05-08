import 'package:nyt/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:nyt/features/articles/data/datasources/local/articles_local_data_source.dart';
import 'package:nyt/features/articles/data/repositories/articles_repository_impl.dart';
import 'package:nyt/features/articles/domain/repositories/article_repository.dart';
import 'package:nyt/features/articles/domain/usecases/most_popular.dart';
import 'package:nyt/features/articles/domain/usecases/search_uc.dart';
import 'package:nyt/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:nyt/features/articles/presentation/cubit/location/location_cubit.dart';

import 'injection_service.dart';

void articleDependencyInfection() {
  sl.registerSingleton<ArticleRemoteDataSource>(
    ArticleRemoteDataSourceImpl(client: sl()),
  );
  sl.registerSingleton<ArticlesLocalDataSource>(
    ArticlesLocalDataSourceImpl(store: sl()),
  );

  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerFactory<SearchArticleUC>(() => SearchArticleUC(repository: sl()));
  sl.registerFactory<MostPopularArticleUC>(() => MostPopularArticleUC(repository: sl()));
  sl.registerSingleton<LocationCubit>(
    LocationCubit(),
  );

  sl.registerSingleton<ArticlesCubit>(
    ArticlesCubit(
      mostPopularArticleUC: sl.get<MostPopularArticleUC>(),
      searchArticleUC: sl.get<SearchArticleUC>(),
    ),
  );
}
