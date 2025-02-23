import 'package:flutter/material.dart';

import '../../../../app_theme.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.controller, this.onChanged});
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: AppTheme.black.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ]),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppTheme.primary,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppTheme.white,
            ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: 'Search movies...',
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppTheme.grey.withOpacity(.7),
              ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppTheme.grey,
            size: 24,
          ),
        ),
      ),
    );
  }
}
