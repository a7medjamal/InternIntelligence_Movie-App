import 'package:flutter/foundation.dart';
import '../data/data_source/searched_movie_api_data_source.dart';
import '../data/models/movie.dart';
import '../data/repo/movie_repo.dart';

class SearchViewModel extends ChangeNotifier {
  late MovieRepo repo;
  bool isLoading = false;
  String? error;
  List<Movie> movies = [];

  SearchViewModel() {
    repo = MovieRepo(dataSource: SearchedMovieApiDataSource());
  }

  Future<void> getSearchedMovies(String query) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      movies = await repo.getMovies(query);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
