import 'dart:math';

import 'package:flutter/material.dart' hide AnimatedSlide;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon_app/configs/colors.dart';
import 'package:flutter_pokemon_app/configs/images.dart';
import 'package:flutter_pokemon_app/domain/entities/pokemon.dart';
import 'package:flutter_pokemon_app/domain/entities/pokemon_props.dart';
import 'package:flutter_pokemon_app/domain/entities/pokemon_types.dart';
import 'package:flutter_pokemon_app/states/pokemon/pokemon_bloc.dart';
import 'package:flutter_pokemon_app/states/pokemon/pokemon_event.dart';
import 'package:flutter_pokemon_app/states/pokemon/pokemon_selector.dart';
import 'package:flutter_pokemon_app/ui/screens/pokemon_info/state_provider.dart';
import 'package:flutter_pokemon_app/ui/widgets/animated_fade.dart';
import 'package:flutter_pokemon_app/ui/widgets/animated_slide.dart';
import 'package:flutter_pokemon_app/ui/widgets/auto_slideup_panel.dart';
import 'package:flutter_pokemon_app/ui/widgets/hero.dart';
import 'package:flutter_pokemon_app/ui/widgets/main_app_bar.dart';
import 'package:flutter_pokemon_app/ui/widgets/main_tab_view.dart';
import 'package:flutter_pokemon_app/ui/widgets/pokemon_image.dart';
import 'package:flutter_pokemon_app/ui/widgets/pokemon_type.dart';
import 'package:flutter_pokemon_app/ui/widgets/progress.dart';
import 'package:flutter_pokemon_app/utils/string.dart';

import '../../../states/theme/theme_cubit.dart';

part 'sections/background_decoration.dart';
part 'sections/pokemon_overall_info.dart';
part 'sections/pokemon_info_card.dart';
part 'sections/pokemon_info_card_about.dart';
part 'sections/pokemon_info_card_basestats.dart';
part 'sections/pokemon_info_card_evolutions.dart';

class PokemonInfo extends StatefulWidget {
  @override
  _PokemonInfoState createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _rotateController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PokemonInfoStateProvider(
      slideController: _slideController,
      rotateController: _rotateController,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _BackgroundDecoration(),
            _PokemonInfoCard(),
            _PokemonOverallInfo(),
          ],
        ),
      ),
    );
  }
}
