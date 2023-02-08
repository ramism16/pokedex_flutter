import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/shared_preferences_controller.dart';

class FavouriteButton extends StatefulWidget {
  final int? pokemonID;
  FavouriteButton(this.pokemonID);

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool favourite = false;

  void checkInFavourites() async {
    print(SharedPreferencesController.instance.favouriteIDs);
    await SharedPreferencesController.readState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (SharedPreferencesController.instance.favouriteIDs.contains(widget.pokemonID))
          favourite = true;
      });
    });
  }

  @override
  void initState() {
    checkInFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (favourite) SharedPreferencesController.removeFavourite(widget.pokemonID);
          else SharedPreferencesController.addFavourite(widget.pokemonID);
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
