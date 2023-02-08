import 'package:pokedex_flutter/models/pokemon.dart';
import 'package:flutter/material.dart';

Color? getPokemonColor(Pokemon pokemon){
  switch (pokemon.types[0].toLowerCase()){
    case "normal": return Color(0xfff8f8f8);
    case "fighting": return Color(0xffFFF9F4);
    case "flying": return Color(0xffFBFAFF);
    case "poison": return Color(0xffF3F1F8);
    case "ground": return Color(0xffF6F4EF);
    case "rock": return Color(0xffF0EFEF);
    case "bug": return Color(0xffFAFDF2);
    case "ghost": return Color(0xffEFECF1);
    case "steel": return Color(0xffF6F6F7);
    case "fire": return Color(0xffFCF6F6);
    case "water": return Color(0xffF7FBFF);
    case "grass": return Color(0xffF2FBF6);
    case "electric": return Color(0xffFEFDF6);
    case "psychic": return Color(0xffFFF9FA);
    case "ice": return Color(0xffF4FBFD);
    case "dragon": return Color(0xffF9F9FF);
    case "dark": return Color(0xffF1F5F4);
    case "fairy": return Color(0xffFFF8FB);
    case "unknown": return Color(0xffFCFCFC);
    case "shadow": return Color(0xffF0FCFB);
  }
}

extension StringExtension on String{
  String capitalize(){
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}

String? typesJoin(List<String>? types){
  if (types == null) return null;
  if (types.isEmpty) return "";
  String typeString = "";
  for (int i = 0; i < types.length; i++){
    typeString += types[i].capitalize();
    if (i + 1 != types.length)
      typeString += ', ';
  }

  return typeString;
}

int? getStatsAverage(List<Stat>? stats){
  if (stats == null) return null;
  int total = 0, i = 0, j = 0;
  for (; i < stats.length; i++){
    if (stats[i].value != null){
      j += 1; total += stats[i].value!;
    }
  }
  return total~/j;
}

String? getID(int? id){
  if (id == null) return null;
  if (id > 1000)
    return '#$id';
  if (id > 100)
    return '#0$id';
  if (id > 10)
    return '#00$id';
  else
    return '#000$id';
}