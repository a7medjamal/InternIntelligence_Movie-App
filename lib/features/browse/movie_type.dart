import 'package:flutter/material.dart';
import 'package:movieapp/api/api_service.dart';

import '../../models/browse_response/MoviesResponse.dart';

class MovieType extends StatefulWidget {
  final Genres categories;

  const MovieType({required this.categories, super.key});

  @override
  State<MovieType> createState() => _MovieTypeState();
}

class _MovieTypeState extends State<MovieType> {
  String? backdropPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFirstMovieImage();
  }

  Future<void> _loadFirstMovieImage() async {
    try {
      final movies = await ApiService.fetchMoviesByGenre(widget.categories.id!);
      if (movies.results != null && movies.results!.isNotEmpty) {
        setState(() {
          backdropPath = movies.results![0].backdropPath;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : backdropPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500$backdropPath',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image,
                            size: MediaQuery.of(context).size.width * 0.75,
                            color: Colors.grey,
                          );
                        },
                      )
                    : Icon(
                        Icons.image,
                        size: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.grey,
                      ),
          ),
        ),
        Center(
          child: Text(
            widget.categories.name ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
