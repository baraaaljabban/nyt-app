import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../Network/http_client.dart';
import '../Network/network_info.dart';
import 'articls.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => Connectivity());

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl());

  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => HttpHelper());
  articleDependencyInfection();
}
