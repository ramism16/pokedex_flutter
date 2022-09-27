import 'package:flutter/material.dart';
import 'package:pokedex_flutter/widgets/pokemon_list_card.dart';
import '../models/pokemon.dart';

class PokemonGrid extends StatefulWidget {
  final List<Pokemon>? pokemonList;
  final bool favouritesList;

  PokemonGrid(this.pokemonList, {this.favouritesList = false});

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  @override
  Widget build(BuildContext context) {
    if (widget.pokemonList == null)
      return Center(child: Text("Pokemon list null"));

    if (widget.pokemonList!.isNotEmpty) {
      if (widget.favouritesList)
        return Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: GridView.count(
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 110 / 190,
            children: List.generate(widget.pokemonList!.length, (index){
              return PokemonListCard(widget.pokemonList![index]);
            })
          ),
        );
      else
        return Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 110 / 190,
                  children: List.generate(widget.pokemonList!.length, (index){
                    return PokemonListCard(widget.pokemonList![index]);
                  })
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                  ],
                )
              ],
            ),
          ),
        );
    }
    else {
      return Center(child: Text("No Pokemon data available",
        style: Theme.of(context).textTheme.headline2));
    }
  }
}
