import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fav_pokemon_event.dart';
part 'fav_pokemon_state.dart';

class FavPokemonBloc extends Bloc<FavPokemonEvent, FavPokemonState> {
  FavPokemonBloc() : super(FavPokemonInitial()) {
    on<FavPokemonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
