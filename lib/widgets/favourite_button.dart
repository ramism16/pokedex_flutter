import 'package:flutter/material.dart';

class FavouriteButton extends StatefulWidget {
  bool favourite = false;
  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.favourite = !widget.favourite;
        });
      },
      child: Card(
        color: widget.favourite ? Color(0xffD5DEFF) : Color(0xff3558CD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: widget.favourite
              ? Text(
                  'Remove from favourites',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Color(0xff3558CD), fontWeight: FontWeight.w900),
                )
              : Text(
                  'Mark as favourite',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                      ),
                ),
        ),
      ),
    );
  }
}
