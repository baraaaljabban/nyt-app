import 'package:flutter/material.dart';
import 'package:nyt/core/AppStrings/error_strings.dart';
import 'package:nyt/core/argument/argument.dart';

class ArticleListController extends StatelessWidget {
  final ArticleListControllerArguments arguments;
  const ArticleListController({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Articles"),
        ),
      ),
      body: arguments.articles.isEmpty
          ? const Text(NO_DATA_FOUND)
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: arguments.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    borderOnForeground: true,
                    clipBehavior: Clip.hardEdge,
                    elevation: 5,
                    child: ListTile(
                      leading: Text("${index + 1}"),
                      title: Text(arguments.articles[index].title),
                      subtitle: Text(arguments.articles[index].publishedDate),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
