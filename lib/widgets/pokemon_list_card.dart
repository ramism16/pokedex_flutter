import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/pokemon.dart';
import '../models/helper.dart' as helper;

class PokemonListCard extends StatelessWidget {
  final Pokemon pokemon;
  PokemonListCard(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
        constraints: BoxConstraints(minWidth: 110, maxHeight: 190),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FadeInImage.assetNetwork(
              placeholder: "assets/icons/pokeball.png",
              placeholderFit: BoxFit.fitWidth,
              image: pokemon.imageURL!,
              fit: BoxFit.fitWidth,
              imageCacheHeight: 200,
              imageCacheWidth: 200,
              imageErrorBuilder: (context, obj, trace)
                => Image.asset("assets/images/pokeball.png", fit: BoxFit.fitWidth),
              placeholderErrorBuilder: (context, obj, trace)
                => SizedBox(width: 100, height: 100)
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text("#${pokemon.id}", style: GoogleFonts.notoSans(
                      color: Color(0xff161A33), fontSize: 16,
                      fontWeight: FontWeight.w400, letterSpacing: 3),),
                  SizedBox(height: 2),
                  Text("${pokemon.name}", style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 10,),
                  Text("${helper.typesJoin(pokemon.types)}"),
                  SizedBox(height: 10)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
