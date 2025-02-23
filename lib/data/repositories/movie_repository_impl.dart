import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, List<Movie>>> _getMovies(
    Future<List<Movie>> Function() getMovies,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await getMovies();
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlaying() async {
    return _getMovies(() => remoteDataSource.getNowPlaying());
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopular() async {
    return _getMovies(() => remoteDataSource.getPopular());
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRated() async {
    return _getMovies(() => remoteDataSource.getTopRated());
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByCategory(String category) async {
    return _getMovies(() => remoteDataSource.getMoviesByCategory(category));
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    return _getMovies(() => remoteDataSource.searchMovies(query));
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final movie = await remoteDataSource.getMovieDetails(id);
        return Right(movie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getSimilarMovies(int id) async {
    return _getMovies(() => remoteDataSource.getSimilarMovies(id));
  }
}