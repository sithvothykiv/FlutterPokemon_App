import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../configs/images.dart';
import '../../../domain/entities/pokemon.dart';
import '../../../routes.dart';
import '../../../states/pokemon/pokemon_bloc.dart';
import '../../../states/pokemon/pokemon_event.dart';
import '../../../states/pokemon/pokemon_selector.dart';
import '../../../states/pokemon/pokemon_state.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/pokemon_card.dart';
import '../../widgets/pokemon_refresh_control.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  static const double _endReachedThreshold = 200;

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  PokemonBloc get pokemonBloc => context.read<PokemonBloc>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      pokemonBloc.add(PokemonLoadStarted());
      _scrollKey.currentState?.innerController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollKey.currentState?.innerController.dispose();
    _scrollKey.currentState?.dispose();

    super.dispose();
  }

  void _onScroll() {
    final innerController = _scrollKey.currentState?.innerController;

    if (innerController == null || !innerController.hasClients) return;

    final thresholdReached = innerController.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      // Load more!
      pokemonBloc.add(PokemonLoadMoreStarted());
    }
  }

  Future _onRefresh() async {
    pokemonBloc.add(PokemonLoadStarted());

    return pokemonBloc.stream.firstWhere((e) => e.status != PokemonStateStatus.loading);
  }

  void _onPokemonPress(Pokemon pokemon) {
    pokemonBloc.add(PokemonSelectChanged(pokemonId: pokemon.number));

    AppNavigator.push(Routes.pokemonInfo, pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          MainSliverAppBar(context: context, title: "Favorite"),
        ],
        body: PokemonStateStatusSelector((status) {
          switch (status) {
            case PokemonStateStatus.loading:
              return _buildLoading();

            case PokemonStateStatus.loadSuccess:
              return Center(
                child: Text("Favorite"),
              ); //_buildGrid();

            case PokemonStateStatus.loadFailure:
              return _buildError();

            default:
              return Container();
          }
        }),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Image(image: AppImages.pikloader),
    );
  }

  Widget _buildError() {
    return CustomScrollView(
      slivers: [
        PokemonRefreshControl(onRefresh: _onRefresh),
        SliverFillRemaining(
          child: Container(
            padding: EdgeInsets.only(bottom: 28),
            alignment: Alignment.center,
            child: Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.black26,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return CustomScrollView(
      slivers: [
        PokemonRefreshControl(onRefresh: _onRefresh),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: NumberOfPokemonsSelector((numberOfPokemons) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  return PokemonSelector(index, (pokemon, _) {
                    return PokemonCard(
                      pokemon,
                      onPress: () => _onPokemonPress(pokemon),
                    );
                  });
                },
                childCount: numberOfPokemons,
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: PokemonCanLoadMoreSelector((canLoadMore) {
            if (!canLoadMore) {
              return SizedBox.shrink();
            }

            return Container(
              padding: EdgeInsets.only(bottom: 28),
              alignment: Alignment.center,
              child: Image(image: AppImages.pikloader),
            );
          }),
        ),
      ],
    );
  }
}
