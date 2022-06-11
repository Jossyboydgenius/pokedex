import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/modules/pokemon_details/widgets/pokemon_panel/pages/moves/widgets/table_moves.dart';
import 'package:pokedex/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:pokedex/shared/ui/widgets/pokemon_type_badge.dart';
import 'package:pokedex/theme/app_theme.dart';

import '../../moves_store.dart';

class TechnicalMachinesMovesTableWidget extends StatelessWidget {
  static final PokemonStore _pokemonStore = GetIt.instance<PokemonStore>();
  final MovesStore movesStore;
  final int index;

  const TechnicalMachinesMovesTableWidget(
      {Key? key, required this.movesStore, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Observer(builder: (_) {
      if (movesStore.panels[index]) {
        return TableMovesWidget(
          columns: [
            Text("TM", style: AppTheme.texts.pokemonTabViewTitle),
            Text("Move", style: AppTheme.texts.pokemonTabViewTitle),
            Text("Type", style: AppTheme.texts.pokemonTabViewTitle),
            Text("Cat.", style: AppTheme.texts.pokemonTabViewTitle),
            Text("Power", style: AppTheme.texts.pokemonTabViewTitle),
            Text("Acc.", style: AppTheme.texts.pokemonTabViewTitle),
          ],
          rows: _pokemonStore.pokemon!.moves.technicalMachine
              .map((move) => [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/technical_machines_types/TM_${move.type}.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(move.technicalMachine.toString(),
                            style: textTheme.bodyText1),
                      ],
                    ),
                    Text(move.move, style: textTheme.bodyText1),
                    PokemonTypeBadge(type: move.type, height: 16, width: 16),
                    Text(move.category, style: textTheme.bodyText1),
                    Text(move.power, style: textTheme.bodyText1),
                    Text(move.accuracy, style: textTheme.bodyText1)
                  ])
              .toList(),
        );
      } else {
        return Container();
      }
    });
  }
}
