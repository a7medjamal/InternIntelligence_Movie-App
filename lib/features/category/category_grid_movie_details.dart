import 'package:flutter/material.dart';

import '../../app_theme.dart';
import 'category_model_movie_details.dart';

class CategoryGridMovieDetails extends StatelessWidget {
  const CategoryGridMovieDetails({super.key, required this.categories});

  final CategoryModelMovieDetails categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.asset(
                  categories.image,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categories.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors
                              .white,
                        ),
                  ),
                  Text(
                    categories.year,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white.withOpacity(.6),
                        ),
                  ),
                  Text(
                    categories.actors,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white.withOpacity(.6),
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Container(
            color: AppTheme.accent,
            height: 4,
          ),
        ],
      ),
    );
  }
}
