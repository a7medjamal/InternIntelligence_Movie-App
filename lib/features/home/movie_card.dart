import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movieapp/api/api_service.dart';
import 'package:movieapp/app_theme.dart';
import 'package:movieapp/widgets/error_indicator.dart';
import 'package:movieapp/widgets/loading_indicator.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    super.key,
    required this.movieId,
  });
  final int movieId;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  late ScrollController _scrollController;
  Timer? _timer;
  double _currentScroll = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    const duration = Duration(milliseconds: 50);
    const scrollAmount = 1.0;

    _timer = Timer.periodic(duration, (timer) {
      if (!mounted) return;

      _currentScroll += scrollAmount;
      if (_scrollController.hasClients) {
        if (_currentScroll >= _scrollController.position.maxScrollExtent) {
          _currentScroll = 0.0;
          _scrollController.jumpTo(0.0);
        } else {
          _scrollController.jumpTo(_currentScroll);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService.fetchSimilarMovies(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError) {
          return const ErrorIndicator();
        } else {
          final similar = snapshot.data;
          return Container(
            color: AppTheme.onBackground.withOpacity(0.2),
            height: MediaQuery.of(context).size.height * 0.38,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: similar?.results?.length ?? 0,
              itemBuilder: (_, index) => Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: 180,
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image at the top
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: similar?.results?[index].posterPath != null
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500/${similar?.results?[index].posterPath}',
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.error,
                                  color: AppTheme.grey,
                                  size:
                                      MediaQuery.of(context).size.height * 0.22,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Icon(
                              Icons.error,
                              color: AppTheme.grey,
                              size: MediaQuery.of(context).size.height * 0.22,
                            ),
                    ),
                    const SizedBox(height: 8),
                    // Movie details below image
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            similar?.results?[index].title ?? 'No Title',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ), // Limit to one line
                          ),
                          const SizedBox(height: 6),

                          // Rating
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                similar?.results?[index].popularity
                                        .toString() ??
                                    'No Rating',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: AppTheme.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 6), // Add spacing between elements

                          // Release Date
                          Text(
                            similar?.results?[index].releaseDate ?? 'No Date',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.white.withOpacity(0.7),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
