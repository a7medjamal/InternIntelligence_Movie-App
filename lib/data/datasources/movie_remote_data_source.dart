import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import '../../core/error/exceptions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getTopRated();
  Future<List<MovieModel>> getMoviesByCategory(String category);
  Future<List<MovieModel>> searchMovies(String query);
  Future<MovieModel> getMovieDetails(int id);
  Future<List<MovieModel>> getSimilarMovies(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  final String? apiKey = dotenv.env['TMDb_API_KEY'];
  final String baseUrl = 'https://api.themoviedb.org/3';

  MovieRemoteDataSourceImpl({required this.client});

  Future<List<MovieModel>> _getMovieList(String endpoint, {Map<String, String>? queryParams}) async {
    final params = {
      'api_key': apiKey ?? '',
      ...?queryParams,
    };

    final response = await client.get(
      Uri.parse('$baseUrl$endpoint').replace(queryParameters: params),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final results = json.decode(response.body)['results'] as List;
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    return _getMovieList('/movie/now_playing');
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    return _getMovieList('/movie/popular');
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    return _getMovieList('/movie/top_rated');
  }

  @override
  Future<List<MovieModel>> getMoviesByCategory(String category) async {
    return _getMovieList('/discover/movie', queryParams: {'with_genres': category});
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    return _getMovieList('/search/movie', queryParams: {'query': query});
  }

  @override
  Future<MovieModel> getMovieDetails(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/movie/$id').replace(
        queryParameters: {'api_key': apiKey},
      ),
    );

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int id) async {
    return _getMovieList('/movie/$id/similar');
  }
}