import 'package:flutter/material.dart';

import '../widgets/search_text_field.dart';
import '../widgets/searched_movie_list.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchTextField(
            controller: searchController,
            onChanged: (value) {
              searchController.text = value;
              setState(() {});
            },
          ),
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
        ),
        body: SearchMoviesList(
          query: searchController.text,
        ));
  }
}
