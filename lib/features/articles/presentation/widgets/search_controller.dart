import 'package:flutter/material.dart';
import 'package:nyt/core/argument/argument.dart';
import 'package:nyt/core/navigation/nav_router.dart';
import 'package:nyt/core/navigation/navigation_service.dart';

class SearchController extends StatefulWidget {
  const SearchController({
    Key? key,
  }) : super(key: key);
  @override
  State<SearchController> createState() => _SearchControllerState();
}

class _SearchControllerState extends State<SearchController> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Search"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              maxLines: 1,
              onSubmitted: (value) {
                _dispatchSearchEvent();
              },
              decoration: InputDecoration(
                isDense: true,
                labelText: "search Articles here..",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                fillColor: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _dispatchSearchEvent();
            },
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }

  void _dispatchSearchEvent() {
    navigationService.navigateTo(
      NavRouter.articlesListView,
      arguments: ArticleListControllerArguments(isFromSearch: true, searchQuery: controller.text),
    );
  }
}
