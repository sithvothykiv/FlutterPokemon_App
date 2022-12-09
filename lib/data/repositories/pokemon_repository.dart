import 'package:flutter_pokemon_app/data/source/api/api_datasource.dart';
import 'package:flutter_pokemon_app/data/source/local/local_datasource.dart';
import 'package:flutter_pokemon_app/data/source/mappers/api_to_local_mapper.dart';
import 'package:flutter_pokemon_app/data/source/mappers/local_to_entity_mapper.dart';
import 'package:flutter_pokemon_app/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getAllPokemons();

  Future<List<Pokemon>> getPokemons({required int limit, required int page});

  Future<Pokemon?> getPokemon(String number);
}

class PokemonDefaultRepository extends PokemonRepository {
  PokemonDefaultRepository({required this.apiDataSource, required this.localDataSource});

  final ApiDataSource apiDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<List<Pokemon>> getAllPokemons() async {
    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      final pokemonModels = await apiDataSource.getPokemons();
      final pokemonHiveModels = pokemonModels.map((e) => e.toHiveModel());

      await localDataSource.savePokemons(pokemonHiveModels);
    }

    final pokemonHiveModels = await localDataSource.getAllPokemons();

    final pokemonEntities = pokemonHiveModels.map((e) => e.toEntity()).toList();

    return pokemonEntities;
  }

  @override
  Future<List<Pokemon>> getPokemons({required int limit, required int page}) async {
    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      final pokemonModels = await apiDataSource.getPokemons();
      final pokemonHiveModels = pokemonModels.map((e) => e.toHiveModel());

      await localDataSource.savePokemons(pokemonHiveModels);
    }

    final pokemonHiveModels = await localDataSource.getPokemons(page: page, limit: limit);
    final pokemonEntities = pokemonHiveModels.map((e) => e.toEntity()).toList();

    return pokemonEntities;
  }

  @override
  Future<Pokemon?> getPokemon(String number) async {
    final pokemonModel = await localDataSource.getPokemon(number);

    if (pokemonModel == null) return null;

    // get all evolutions
    final evolutions = await localDataSource.getEvolutions(pokemonModel);

    final pokemon = pokemonModel.toEntity(evolutions: evolutions);

    return pokemon;
  }
}
