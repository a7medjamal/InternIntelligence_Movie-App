import 'package:flutter/material.dart';
import 'package:movieapp/api/api_service.dart';
import 'package:movieapp/app_theme.dart';
import 'package:movieapp/features/home/movie_card.dart';
import 'package:movieapp/widgets/loading_indicator.dart';
import '../../widgets/error_indicator.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});
  static const String routName = 'detailsScreen';

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int? movieId;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) {
      movieId = args;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text("Movies"),
      ),
      body: movieId == null
          ? const Center(
              child: Text("Invalid movie ID",
                  style: TextStyle(color: Colors.white)))
          : ListView(
              children: [
                FutureBuilder(
                  future: ApiService.fetchMovieDetails(movieId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingIndicator();
                    } else if (snapshot.hasError) {
                      return const ErrorIndicator();
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                          child: Text("No movie details available.",
                              style: TextStyle(color: Colors.white)));
                    }
                    final movie = snapshot.data;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: movie?.posterPath != null
                                    ? Image.network(
                                        'https://image.tmdb.org/t/p/w500/${movie?.posterPath}',
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.image,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.22,
                                            color: Colors.grey,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      )
                                    : Icon(
                                        Icons.image,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        color: Colors.grey,
                                      ),
                              ),
                              Center(
                                child: Text(
                                  movie?.originalTitle ?? 'No Title',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  movie?.releaseDate ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 14,
                                        color: AppTheme.grey,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(
                                  color: AppTheme.grey,
                                  thickness: 0.5,
                                  height: 0),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        // Overview text
                                        Text(
                                          formatText(
                                              'Overview:\n${movie!.overview}',
                                              30),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          textAlign: TextAlign.justify,
                                        ),
                                        const SizedBox(height: 18),
                                        // Rating
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Text(
                                              movie.voteAverage.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        MovieCard(
                          movieId: movieId!,
                        ),
                        // Movie Card
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }

  String formatText(String text, int maxCharsPerLine) {
    List<String> lines = [];
    for (int i = 0; i < text.length; i += maxCharsPerLine) {
      lines.add(text.substring(
          i,
          i + maxCharsPerLine > text.length
              ? text.length
              : i + maxCharsPerLine));
    }
    return lines.join('\n');
  }
}
