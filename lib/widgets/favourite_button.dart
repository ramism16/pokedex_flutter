import 'package:flutter/material.dart';
import 'package:pokedex_flutter/models/user.dart';

class FavouriteButton extends StatefulWidget {
  final int? pokemonID;
  FavouriteButton(this.pokemonID);

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool favourite = false;

  @override
  void initState() {
    if (User.instance.favouriteIDs.contains(widget.pokemonID))
      favourite = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (favourite) User.removeFavourite(widget.pokemonID);
          else User.addFavourite(widget.pokemonID);
          favourite = !favourite;
        });
      },
      child: Card(
        color: favourite ? Color(0xffD5DEFF) : Color(0xff3558CD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: favourite
              ? Text(
                  'Remove from favourites',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Color(0xff3558CD), fontWeight: FontWeight.w900),
                )
              : Text(
                  'Mark as favourite',
                  style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white,),
                ),
        ),
      ),
    );
  }
}
