import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon_app/domain/entities/pokemon.dart';
import 'package:flutter_pokemon_app/states/pokemon/pokemon_bloc.dart';
import 'package:flutter_pokemon_app/states/pokemon/pokemon_state.dart';

class FavPokemonStateSelector<T> extends BlocSelector<PokemonBloc, PokemonState, T> {
  FavPokemonStateSelector({
    required T Function(PokemonState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class FavPokemonStateStatusSelector extends FavPokemonStateSelector<PokemonStateStatus> {
  FavPokemonStateStatusSelector(Widget Function(PokemonStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class FavPokemonCanLoadMoreSelector extends FavPokemonStateSelector<bool> {
  FavPokemonCanLoadMoreSelector(Widget Function(bool) builder)
      : super(
          selector: (state) => state.canLoadMore,
          builder: builder,
        );
}

class FavNumberOfPokemonsSelector extends FavPokemonStateSelector<int> {
  FavNumberOfPokemonsSelector(Widget Function(int) builder)
      : super(
          selector: (state) => state.pokemons.length,
          builder: builder,
        );
}

class FavCurrentPokemonSelector extends FavPokemonStateSelector<Pokemon> {
  FavCurrentPokemonSelector(Widget Function(Pokemon) builder)
      : super(
          selector: (state) => state.selectedPokemon,
          builder: builder,
        );
}

class FavPokemonSelector extends FavPokemonStateSelector<FavPokemonSelectorState> {
  FavPokemonSelector(int index, Widget Function(Pokemon, bool) builder)
      : super(
          selector: (state) => FavPokemonSelectorState(
            state.pokemons[index],
            state.selectedPokemonIndex == index,
          ),
          builder: (value) => builder(value.pokemon, value.selected),
        );
}

class FavPokemonSelectorState {
  final Pokemon pokemon;
  final bool selected;

  const FavPokemonSelectorState(this.pokemon, this.selected);

  @override
  bool operator ==(Object other) => other is FavPokemonSelectorState && pokemon == other.pokemon && selected == other.selected;
}
