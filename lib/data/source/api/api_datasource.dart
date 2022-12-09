import 'dart:convert';

import 'package:flutter_pokemon_app/core/network.dart';
import 'package:flutter_pokemon_app/data/source/api/models/pokemon.dart';

class ApiDataSource {
  ApiDataSource(this.networkManager);

  static const String itemsURL = 'https://gist.githubusercontent.com/hungps/48f4355fb1a89ddaf47f56961dc8a245/raw/pokemon-items.json';

  static const String url = 'https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json';

  final NetworkManager networkManager;

  Future<List<PokemonModel>> getPokemons() async {
    final response = await networkManager.request(RequestMethod.get, url);

    final data = (json.decode(response.data) as List).map((item) => PokemonModel.fromJson(item)).toList();

    return data;
  }
}
