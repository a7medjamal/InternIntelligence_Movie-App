import 'package:flutter/material.dart';
import 'package:movieapp/app_theme.dart';
import 'package:movieapp/features/home/home_details_screen.dart';
import 'package:movieapp/features/home/home_tap.dart';
import 'package:movieapp/home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routName: (_) => const HomeScreen(),
        HomeTap.routeName: (_) => const HomeTap(),
        HomeDetailsScreen.routName: (_) => const HomeDetailsScreen(),
      },
      themeMode: ThemeMode.light,
      theme: AppTheme.theme,
    );
  }
}
