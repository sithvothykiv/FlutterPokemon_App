import 'package:flutter_pokemon_app/data/source/api/api_datasource.dart';
import 'package:flutter_pokemon_app/data/source/local/local_datasource.dart';
import 'package:flutter_pokemon_app/data/source/mappers/api_to_local_mapper.dart';
import 'package:flutter_pokemon_app/data/source/mappers/local_to_entity_mapper.dart';
import 'package:flutter_pokemon_app/domain/entities/pokemon.dart';

import '../source/api/models/pokemon.dart';

abstract class FavoritePokemonRepository {
  Future<List<Pokemon>> getAllFavoritePokemons();
  Future saveFavoritePokemon(PokemonModel pokemonModel);
}

class FavoritePokemonDefaultRepository extends FavoritePokemonRepository {
  FavoritePokemonDefaultRepository({required this.localDataSource});

  final LocalDataSource localDataSource;

  @override
  Future<List<Pokemon>> getAllFavoritePokemons() async {
    final pokemonHiveModels = await localDataSource.getAllPokemons();

    final pokemonEntities = pokemonHiveModels.map((e) => e.toEntity()).toList();

    return pokemonEntities;
  }

  @override
  Future saveFavoritePokemon(PokemonModel pokemonModel) async {
    // TODO: implement saveFavoritePokemons
    final pokemonHiveModels = pokemonModel.toHiveModel();
    await localDataSource.saveFavoritePokemon(pokemonHiveModels);
  }
}
