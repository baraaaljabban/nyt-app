import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt/core/AppStrings/error_strings.dart';
import 'package:nyt/core/argument/argument.dart';
import 'package:nyt/core/enum/articles_type.dart';
import 'package:nyt/features/articles/domain/usecases/most_popular.dart';
import 'package:nyt/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:nyt/features/common/snack_bar.dart';

class ArticleListController extends StatefulWidget {
  final ArticleListControllerArguments arguments;
  const ArticleListController({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ArticleListController> createState() => _ArticleListControllerState();
}

class _ArticleListControllerState extends State<ArticleListController> with SnackBarHelper {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (widget.arguments.isFromSearch) {
      BlocProvider.of<ArticlesCubit>(context).searchForAnArticle(query: widget.arguments.searchQuery ?? '');
    } else {
      BlocProvider.of<ArticlesCubit>(context).getArticlesList(
        params: MostPopularArticleParams(
          days: widget.arguments.days ?? 1,
          type: widget.arguments.articleType ?? ArticleType.viewed,
        ),
      );
    }
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Articles"),
          ),
        ),
        body: BlocConsumer<ArticlesCubit, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesErrorState) {
              SnackBarHelper.showErrorSnackBar(context, message: state.message);
            }
          },
          builder: (context, state) {
            if (state is ArticlesSuccessState) {
              return state.articles.isEmpty
                  ? const Text(NO_DATA_FOUND)
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.articles.length + 1,
                        controller: state.reachedMax ? null : _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < state.articles.length) {
                            return Card(
                              borderOnForeground: true,
                              clipBehavior: Clip.hardEdge,
                              elevation: 5,
                              child: ListTile(
                                leading: Text("${index + 1}"),
                                title: Text(state.articles[index].title),
                                subtitle: Text(state.articles[index].publishedDate),
                              ),
                            );
                          } else if (!state.reachedMax) {
                            return Container(
                              margin: const EdgeInsets.all(16),
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                    );
            } else if (state is ArticlesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      BlocProvider.of<ArticlesCubit>(context).loadMoreArticlesList();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
