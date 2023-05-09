import 'package:flutter/material.dart';
import 'package:nyt/core/argument/argument.dart';
import 'package:nyt/features/articles/presentation/pages/articles_page.dart';
import 'package:nyt/features/articles/presentation/widgets/article_list_controller.dart';
import 'package:nyt/features/articles/presentation/widgets/search_controller.dart';

class NavRouter {
  NavRouter._();

  static const String initialRoute = '/';
  static const String searchView = '/search_view';
  static const String articlesListView = '/articles_list_view';

  static MaterialPageRoute _pageRoute(
    Widget page,
    settings,
  ) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return _pageRoute(
          const ArticlesPage(),
          settings,
        );

      case articlesListView:
        return _pageRoute(
          ArticleListController(
            arguments: settings.arguments as ArticleListControllerArguments,
          ),
          settings,
        );

      case searchView:
        return _pageRoute(
          const SearchController(),
          settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
