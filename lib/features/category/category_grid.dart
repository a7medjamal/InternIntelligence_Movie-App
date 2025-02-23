import 'package:flutter/material.dart';

import 'category_model.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Image.asset(
            category.image,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: Text(
            category.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
