import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt/core/argument/argument.dart';
import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/core/navigation/nav_router.dart';
import 'package:nyt/core/navigation/navigation_service.dart';
import 'package:nyt/features/articles/domain/usecases/most_popular.dart';
import 'package:nyt/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:nyt/features/articles/presentation/widgets/location_controller.dart';
import 'package:nyt/features/common/snack_bar.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> with SnackBarHelper {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticlesCubit, ArticlesState>(
      listener: (context, state) {
        if (state is ArticlesLoadingState) {
          SnackBarHelper.showLoadingSnackBar(context);
        } else if (state is ArticlesErrorState) {
          SnackBarHelper.showErrorSnackBar(context, message: state.message);
        } else if (state is ArticlesSuccessState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          navigationService.navigateTo(NavRouter.articlesListView, arguments: ArticleListControllerArguments(articles: state.articles));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Center(child: Text("NYT")),
          ),
          body: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  const Text(
                    "Search",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      goToSearchController(context);
                    },
                    child: const MyCard(
                      icon: Icon(Icons.search),
                      title: ("Search Articles"),
                    ),
                  ),
                  const Spacer(flex: 1),
                  const Text(
                    "Popular ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      getTheMostPopular(ArticleType.emailed, context);
                    },
                    child: const MyCard(
                      title: "Most Emailed",
                      icon: Icon(Icons.email),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getTheMostPopular(ArticleType.viewed, context);
                    },
                    child: const MyCard(
                      title: "Most Viewed",
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getTheMostPopular(ArticleType.shared, context);
                    },
                    child: const MyCard(
                      title: "Most Shared",
                      icon: Icon(Icons.share),
                    ),
                  ),
                  const Spacer(flex: 2),
                  const LocationController()
                ],
              )),
        );
      },
    );
  }
}

void getTheMostPopular(ArticleType type, BuildContext context) {
  BlocProvider.of<ArticlesCubit>(context).getArticlesList(
    params: MostPopularArticleParams(days: 7, type: type),
  );
}

void goToSearchController(BuildContext context) {
  navigationService.navigateTo(NavRouter.searchView);
}

class MyCard extends StatelessWidget {
  final String title;
  final Icon icon;
  const MyCard({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: ListTile(
        leading: icon,
        title: Text(title),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }
}
