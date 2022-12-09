import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/core/fade_page_route.dart';
import 'package:flutter_pokemon_app/ui/screens/home/home_screen.dart';
import 'package:flutter_pokemon_app/ui/screens/pokemon_info/pokemon_info.dart';

enum Routes { home, pokemon, pokemonInfo, typeEffects, items }

class _Paths {
  static const String home = '/';
  static const String pokemonInfo = '/home/pokemonInfo';

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.home,
    Routes.pokemonInfo: _Paths.pokemonInfo,
  };

  static String of(Routes route) => _pathMap[route] ?? '/';
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.pokemonInfo:
        return FadeRoute(page: PokemonInfo());

      case _Paths.home:
      default:
        return FadeRoute(page: HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) => state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) => state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
