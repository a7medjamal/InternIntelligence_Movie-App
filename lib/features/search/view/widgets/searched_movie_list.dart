import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/search_response/view_model/search_view_model.dart';
import '../../../../widgets/error_indicator.dart';
import '../../../../widgets/loading_indicator.dart';
import 'movie_item_search.dart';

class SearchMoviesList extends StatefulWidget {
  const SearchMoviesList({super.key, required this.query});
  final String query;

  @override
  State<SearchMoviesList> createState() => _SearchMoviesListState();
}

class _SearchMoviesListState extends State<SearchMoviesList> {
  final viewModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    if (widget.query.isNotEmpty) {
      viewModel.getSearchedMovies(widget.query);
    }

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: widget.query.isEmpty
          ? SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No movies found',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          : Consumer<SearchViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.isLoading) {
                  return const LoadingIndicator();
                } else if (viewModel.error != null) {
                  return const ErrorIndicator();
                } else if (viewModel.movies.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (_, index) => MovieItemSearch(
                      movie: viewModel.movies[index],
                    ),
                    itemCount: viewModel.movies.length,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
    );
  }
}
