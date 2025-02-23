import 'package:flutter/material.dart';
import 'package:movieapp/features/search/view/screens/movie_detail_page.dart';

import '../../../../app_theme.dart';
import '../../../../models/search_response/data/models/movie.dart';

class MovieItemSearch extends StatefulWidget {
  const MovieItemSearch({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieItemSearch> createState() => _MovieItemSearchState();
}

class _MovieItemSearchState extends State<MovieItemSearch> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: widget.movie),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailPage(movie: widget.movie),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: widget.movie.posterPath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image,
                                size: 100,
                                color: AppTheme.grey,
                              );
                            },
                          )
                        : Icon(
                            Icons.image,
                            size: 100,
                            color: AppTheme.grey,
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.movie.releaseDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.white.withOpacity(.6),
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _isExpanded
                            ? widget.movie.overview
                            : widget.movie.overview.length > 100
                                ? '${widget.movie.overview.substring(0, 100)}...'
                                : widget.movie.overview,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.white.withOpacity(.6),
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: _isExpanded ? null : 3,
                      ),
                      const SizedBox(height: 5),
                      if (widget.movie.overview.length > 100)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(
                            !_isExpanded ? 'See less' : 'See more',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
