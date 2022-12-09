import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/ui/screens/home/favorite_screen.dart';

import 'package:flutter_pokemon_app/ui/screens/home/sections/pokemon_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[PokemonGrid(), FavoriteScreen()];
  void _onItemTapped(int index) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _currentIndex = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex), //PokemonGrid(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).textTheme.bodyLarge!.color),
            label: 'Home',
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined, color: Theme.of(context).textTheme.bodyLarge!.color),
            label: 'Favorite',
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
