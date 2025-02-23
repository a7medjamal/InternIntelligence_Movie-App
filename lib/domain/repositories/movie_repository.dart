import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../../core/error/failures.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, List<Movie>>> getTopRated();
  Future<Either<Failure, List<Movie>>> getMoviesByCategory(String category);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, Movie>> getMovieDetails(int id);
  Future<Either<Failure, List<Movie>>> getSimilarMovies(int id);
}
