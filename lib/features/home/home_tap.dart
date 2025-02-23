// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/constant.dart';
import 'package:movieapp/features/home/home_details_screen.dart';

import '../../api/api_service.dart';
import '../../app_theme.dart';
import '../../models/home_response/Popular.dart';
import '../../models/home_response/Recommended.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});
  static const String routeName = 'hometap';

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  bool isLoading = true;
  bool hasError = false;
  List<ResultsPopular> resultsPopular = [];
  List<ResultsPopular> resultsReal = [];
  List<ResultsRecommended> resultsRecommended = [];
  Set<int> favoriteNewReleases = {};
  Set<int> favoriteRecommended = {};

  Future<void> getMovie() async {
    try {
      final moviesData = await ApiService.fetchMovies();
      setState(() {
        resultsPopular = (moviesData['popular'] as List<dynamic>)
            .map((v) => ResultsPopular.fromJson(v))
            .toList();
        resultsReal = (moviesData['upcoming'] as List<dynamic>)
            .map((v) => ResultsPopular.fromJson(v))
            .toList();
        resultsRecommended = (moviesData['popular'] as List<dynamic>)
            .map((v) => ResultsRecommended.fromJson(v))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setState(() {
        hasError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMovie();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(child: Text('Error fetching data. Please try again.'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (resultsPopular.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      HomeDetailsScreen.routName,
                      arguments: resultsPopular[1].id,
                    );
                  }
                },
                child: Image.network(
                  resultsPopular.isNotEmpty &&
                          resultsPopular[1].backdropPath.isNotEmpty
                      ? 'https://image.tmdb.org/t/p/w500${resultsPopular[1].backdropPath}'
                      : defaultImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: const Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () {
                          if (resultsPopular.isNotEmpty) {
                            Navigator.pushNamed(
                              context,
                              HomeDetailsScreen.routName,
                              arguments: resultsPopular[1].id,
                            );
                          }
                        },
                        child: Image.network(
                          resultsPopular.isNotEmpty &&
                                  resultsPopular[1].posterPath.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/w500${resultsPopular[1].posterPath}'
                              : 'https://via.placeholder.com/100x150',
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              child: const Center(child: Icon(Icons.error)),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resultsPopular.isNotEmpty &&
                                    resultsPopular[1].title.isNotEmpty
                                ? resultsPopular[1].title
                                : 'Title Not Available',
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${resultsPopular.isNotEmpty && resultsPopular[0].releaseDate.isNotEmpty ? resultsPopular[0].releaseDate : 'Data Not Available'} ${resultsPopular.isNotEmpty ? '${resultsPopular[0].voteAverage}/10' : ''}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'New Releases',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            color: AppTheme.accent,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: resultsReal.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            HomeDetailsScreen.routName,
                            arguments: resultsReal[index].id,
                          );
                        },
                        child: Image.network(
                          resultsReal[index].posterPath.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/w500${resultsReal[index].posterPath}'
                              : 'https://via.placeholder.com/100x150',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Recommended',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            height: 200,
            color: AppTheme.accent,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: resultsRecommended.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            HomeDetailsScreen.routName,
                            arguments: resultsRecommended[index].id,
                          );
                        },
                        child: Image.network(
                          resultsRecommended[index].posterPath.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/w500${resultsRecommended[index].posterPath}'
                              : 'https://via.placeholder.com/100x150',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
