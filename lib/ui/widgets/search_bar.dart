import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon_app/ui/widgets/spacer.dart';

import '../../configs/colors.dart';
import '../../states/theme/theme_cubit.dart';

class SearchBar extends StatelessWidget {
  const SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 26,
            color: BlocProvider.of<ThemeCubit>(context, listen: false).isDark ? Colors.white : Colors.black,
          ),
          HSpacer(8),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search Pokemon, Move, Ability etc',
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: BlocProvider.of<ThemeCubit>(context, listen: false).isDark ? Colors.white : Colors.black,
                  height: 1,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
