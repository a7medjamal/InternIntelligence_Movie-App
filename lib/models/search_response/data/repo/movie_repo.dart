
import '../data_source/movies_data_source.dart';
import '../models/movie.dart';

class MovieRepo {
  MoviesDataSource dataSource;
  MovieRepo({
    required this.dataSource,
  });
  Future<List<Movie>> getMovies(String query) async {
    return dataSource.getMovies(query);
  }
}
