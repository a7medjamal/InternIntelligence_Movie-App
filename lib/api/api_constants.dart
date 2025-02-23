// ignore_for_file: constant_identifier_names

class APIConstants {
  static const String baseURL = 'api.themoviedb.org';

  static const String moviesEndPoint = '/3/movie/popular';
  static const String upcomingEndPoint = '/3/movie/upcoming';
  static const String recommendedEndPoint = '/3/movie/recommendations';
  static const String genreEndPoint = '/3/genre/movie/list';
  static const String moviesDetailsEndPoint = '/3/discover/movie';
  static const String moviesSearchEndPoint = '/3/search/movie';
  static const String moviesEndPointBrowse = '/3/genre/movie/list';
  static const String apiKey = 'efe609b0bdfb6ffffe19516c5d3bb2b6';
  static const String Authorization =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MDkzMWFlOGYyYzg3NmQzMjRkMzNlZGQ5Y2Y4MTMzMiIsIm5iZiI6MTc0MDI2NDAwNy4yNjEsInN1YiI6IjY3YmE1MjQ3YTIzOTI5YWMyOGJlYzBjMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YS3rZLNx1otCVnWveFNJj_hpAd6aPfL99aOmIpVyzPU';
  static const String language = 'en';
}
