import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:nyt/features/articles/presentation/cubit/location/location_cubit.dart';

import 'core/Service/injection_service.dart';
import 'core/navigation/nav_router.dart';
import 'core/navigation/navigation_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticlesCubit>(
          create: (BuildContext context) => sl<ArticlesCubit>(),
        ),
        BlocProvider<LocationCubit>(
          create: (BuildContext context) => sl<LocationCubit>(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: NavRouter.generateRoute,
        navigatorKey: navigationService.navigationKey,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
