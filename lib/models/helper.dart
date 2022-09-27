import 'package:pokedex_flutter/models/pokemon.dart';
import 'package:flutter/material.dart';

Color? getPokemonColor(Pokemon pokemon){
  switch (pokemon.types[0].toLowerCase()){
    case "normal": return Color(0xffbec3c6);
    case "fighting": return Color(0xffffb673);
    case "flying": return Color(0xffede3ff);
    case "poison": return Color(0xffa38dc9);
    case "ground": return Color(0xffc3b090);
    case "rock": return Color(0xff999999);
    case "bug": return Color(0xffb3e820);
    case "ghost": return Color(0xff553D6B);
    case "steel": return Color(0xffA3A3A8);
    case "fire": return Color(0xffC54644);
    case "water": return Color(0xffA8D9FF);
    case "grass": return Color(0xff21B86C);
    case "electric": return Color(0xffF6EB61);
    case "psychic": return Color(0xffFFD1DA);
    case "ice": return Color(0xff59CBE8);
    case "dragon": return Color(0xff4D4DFF);
    case "dark": return Color(0xff417571);
    case "fairy": return Color(0xffFFBFD9);
    case "unknown": return Color(0xffE1E5E8);
    case "shadow": return Color(0xff417571);
  }
}

extension StringExtension on String{
  String capitalize(){
    return "${this[0].toLowerCase()}${this.substring(1).toLowerCase()}";
  }
}

String? typesJoin(List<String>? types){
  if (types == null) return null;
  if (types.isEmpty) return "";
  String typeString = "";
  for (var type in types)
    { typeString += '${type.capitalize()}${types.length > 1 ? ", " : ""}'; }
  return typeString;
}
