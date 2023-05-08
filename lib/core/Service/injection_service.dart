// ignore_for_file: depend_on_referenced_packages

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:nyt/core/Network/http_client.dart';
import 'package:nyt/core/Network/network_info.dart';
import 'package:nyt/objectbox.g.dart';

import 'articles.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => Connectivity());

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<HttpClient>(
    () => HttpClientImpl(connectionChecker: sl.get()),
  );
  final store = await _getStore;
  sl.registerLazySingleton(() {
    return store;
  });

  articleDependencyInfection();
}

Future<Store> get _getStore async {
  final appdirectory = await getApplicationDocumentsDirectory();
  try {
    if (Store.isOpen(join(appdirectory.path, "objectBoxs"))) {
      // applicable when store is from other isolate
      return Store.attach(getObjectBoxModel(), join(appdirectory.path, "objectBoxs"));
    }
    return await openStore(directory: join(appdirectory.path, "objectBoxs"));
  } catch (_) {
    return Store.attach(getObjectBoxModel(), join(appdirectory.path, "objectBoxs"));
  }
}
