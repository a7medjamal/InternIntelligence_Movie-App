import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/browse_response/MoviesResponse.dart';
import '../models/browse_response/TypeOfMoviesResponse.dart';
import '../models/home_details_response/movie_response/movie_response.dart';
import '../models/home_details_response/similar/similar_response.dart';
import 'api_constants.dart';

class ApiService {
  static Future<MoviesResponse> fetchGenres() async {
    final uri =
        Uri.https(APIConstants.baseURL, APIConstants.moviesEndPointBrowse, {
      'language': 'en',
    });

    final response = await http.get(uri, headers: {
      'Authorization': APIConstants.Authorization,
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MoviesResponse.fromJson(json);
    } else {
      throw Exception('Failed to load genres: ${response.statusCode}');
    }
  }

  static Future<TypeOfMoviesResponse> fetchMoviesByGenre(int genreId) async {
    final uri =
        Uri.https(APIConstants.baseURL, APIConstants.moviesDetailsEndPoint, {
      'language': 'en',
      'with_genres': genreId.toString(),
    });

    final response = await http.get(uri, headers: {
      'Authorization': APIConstants.Authorization,
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return TypeOfMoviesResponse.fromJson(json);
    } else {
      throw Exception('Failed to load movies by genre: ${response.statusCode}');
    }
  }

  static Future<MovieResponseDetails> fetchMovieDetails(int movieId) async {
    final url = Uri.https(APIConstants.baseURL, '/3/movie/$movieId', {
      'language': 'en-US',
    });

    final response = await http.get(url, headers: {
      'Authorization': APIConstants.Authorization,
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MovieResponseDetails.fromJson(json);
    } else {
      throw Exception('Failed to load movie details: ${response.statusCode}');
    }
  }

  static Future<SimilarResponse> fetchSimilarMovies(int movieId) async {
    final url = Uri.https(APIConstants.baseURL, '/3/movie/$movieId/similar', {
      'language': 'en-US',
    });

    final response = await http.get(url, headers: {
      'Authorization': APIConstants.Authorization,
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SimilarResponse.fromJson(json);
    } else {
      throw Exception('Failed to load similar movies: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> fetchMovies() async {
    final popularUri =
        Uri.https(APIConstants.baseURL, APIConstants.moviesEndPoint, {
      'language': APIConstants.language,
    });

    final upcomingUri =
        Uri.https(APIConstants.baseURL, APIConstants.upcomingEndPoint, {
      'language': APIConstants.language,
    });

    final popularResponse = await http.get(popularUri, headers: {
      'Authorization': APIConstants.Authorization,
      'Accept': 'application/json',
    });

    final upcomingResponse = await http.get(upcomingUri, headers: {
      'Authorization': APIConstants.Authorization,
      'Accept': 'application/json',
    });

    if (popularResponse.statusCode == 200 &&
        upcomingResponse.statusCode == 200) {
      return {
        'popular': jsonDecode(popularResponse.body)['results'],
        'upcoming': jsonDecode(upcomingResponse.body)['results'],
      };
    } else {
      throw Exception(
          'Failed to load movies: Popular(${popularResponse.statusCode}), Upcoming(${upcomingResponse.statusCode})');
    }
  }
}
