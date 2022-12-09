import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon_app/app.dart';
import 'package:flutter_pokemon_app/core/network.dart';
import 'package:flutter_pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:flutter_pokemon_app/data/source/api/api_datasource.dart';
import 'package:flutter_pokemon_app/data/source/local/local_datasource.dart';
import 'package:flutter_pokemon_app/states/theme/theme_cubit.dart';
import 'package:flutter_pokemon_app/states/pokemon/pokemon_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDataSource.initialize();

  runApp(
    MultiRepositoryProvider(
      providers: [
        ///
        /// Services
        ///
        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),

        ///
        /// Data sources
        ///
        RepositoryProvider<LocalDataSource>(
          create: (context) => LocalDataSource(),
        ),
        RepositoryProvider<ApiDataSource>(
          create: (context) => ApiDataSource(context.read<NetworkManager>()),
        ),

        ///
        /// Repositories
        ///
        RepositoryProvider<PokemonRepository>(
          create: (context) => PokemonDefaultRepository(
            localDataSource: context.read<LocalDataSource>(),
            apiDataSource: context.read<ApiDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          ///
          /// BLoCs
          ///
          BlocProvider<PokemonBloc>(
            create: (context) => PokemonBloc(context.read<PokemonRepository>()),
          ),

          ///
          /// Theme Cubit
          ///
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          )
        ],
        child: PokedexApp(),
      ),
    ),
  );
}
