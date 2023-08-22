import 'package:flutter/material.dart';
import 'package:peter_s_application2/presentation/home_screen/home_screen.dart';
import 'package:peter_s_application2/presentation/favorite_screen/favorite_screen.dart';
import 'package:peter_s_application2/presentation/favorite_screen_while_using_search_screen/favorite_screen_while_using_search_screen.dart';
import 'package:peter_s_application2/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';
  static const String favoriteScreen = '/favorite_screen';
  static const String favoriteScreenWhileUsingSearchScreen =
      '/favorite_screen_while_using_search_screen';
  static const String appNavigationScreen = '/app_navigation_screen';

  static List<String> favoriteQuotes = [];

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (context) => HomeScreen(),
    favoriteScreen: (context) => FavoriteScreen(
      favoriteQuotes: favoriteQuotes,
      quoteText: '',
      quoteAuthor: '',
      onRemove: (String quote) {
        // Remove the quote from favorites
        favoriteQuotes.remove(quote);
      },
    ),
    favoriteScreenWhileUsingSearchScreen: (context) =>
        FavoriteScreenWhileUsingSearchScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
  };
}