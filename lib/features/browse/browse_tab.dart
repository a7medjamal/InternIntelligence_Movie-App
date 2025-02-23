import 'package:flutter/material.dart';

import '../../api/api_service.dart';

import '../../models/browse_response/MoviesResponse.dart';
import '../../widgets/error_indicator.dart';
import '../../widgets/loading_indicator.dart';
import 'details_of_movie.dart';
import 'movie_type.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});
  static const routeName = 'browse';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Category',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<MoviesResponse>(
        future: ApiService.fetchGenres(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return const ErrorIndicator();
          } else if (snapshot.hasData) {
            final categories = snapshot.data!.genres ?? [];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsOfMovie(
                            movieName: categories[index].name ?? '',
                            genreId: categories[index].id ?? 0,
                          ),
                        ),
                      );
                    },
                    child: MovieType(categories: categories[index]),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No genres available'));
          }
        },
      ),
    );
  }
}
