import 'package:flutter/material.dart';
import 'package:movieapp/models/search_response/data/models/movie.dart';
import 'package:movieapp/features/search/view/screens/movie_detail_page.dart';
import '../../api/api_service.dart';
import '../../models/browse_response/TypeOfMoviesResponse.dart';
import '../../widgets/error_indicator.dart';
import '../../widgets/loading_indicator.dart';

class DetailsOfMovie extends StatelessWidget {
  final String movieName;
  final int genreId;

  const DetailsOfMovie(
      {super.key, required this.movieName, required this.genreId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<TypeOfMoviesResponse>(
        future: ApiService.fetchMoviesByGenre(genreId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return const ErrorIndicator();
          } else if (snapshot.hasData) {
            final categories = snapshot.data!.results ?? [];
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                MovieResult movie = categories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            movie: Movie(
                              id: movie.id ?? 0,
                              title: movie.title ?? 'No Title',
                              overview: movie.overview ?? 'No Overview',
                              posterPath: movie.posterPath,
                              releaseDate:
                                  movie.releaseDate ?? 'No Release Date',
                              voteAverage: movie.voteAverage ?? 0.0,
                              voteCount: movie.voteCount ?? 0,
                              backdropPath: movie.backdropPath ?? '',
                              genreIds: movie.genreIds ?? [],
                              originalLanguage: movie.originalLanguage ?? '',
                              originalTitle: movie.originalTitle ?? '',
                              popularity: movie.popularity ?? 0.0,
                              adult: movie.adult ?? false,
                            ), // Pass the movie object to the next page
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image,
                                size: 150,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                movie.releaseDate ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                movie.overview ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
