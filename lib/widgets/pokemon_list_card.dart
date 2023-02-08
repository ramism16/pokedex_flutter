import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/pokemon.dart';
import '../models/helper.dart';

class PokemonListCard extends StatefulWidget {
  final Pokemon pokemon;
  PokemonListCard(this.pokemon);

  @override
  State<PokemonListCard> createState() => _PokemonListCardState();
}

class _PokemonListCardState extends State<PokemonListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/Details', arguments: widget.pokemon);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
        constraints: BoxConstraints(minWidth: 110, maxHeight: 190),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10,),
            FadeInImage.assetNetwork(
              placeholder: "assets/pokeball.png",
              placeholderFit: BoxFit.fitWidth,
              image: widget.pokemon.imageURL!,
              fit: BoxFit.fitWidth,
              imageCacheHeight: 200,
              imageCacheWidth: 200,
              imageErrorBuilder: (context, obj, trace)
                => Image.asset("assets/pokeball.png", fit: BoxFit.fitWidth),
              placeholderErrorBuilder: (context, obj, trace)
                => SizedBox(width: 100, height: 100)
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${getID(widget.pokemon.id)}", style: GoogleFonts.notoSans(
                      color: Color(0xff161A33), fontSize: 16,
                      fontWeight: FontWeight.w400),),
                  SizedBox(height: 2),
                  Text("${widget.pokemon.name?.capitalize()}", style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 10,),
                  Text("${typesJoin(widget.pokemon.types)}"),
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
