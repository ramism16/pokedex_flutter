import 'package:dio/dio.dart';
import 'package:pokedex_flutter/models/pokemon.dart';

Future<List<Pokemon>?>? getNextPokemons(int limit, int offset) async {
  List<Pokemon> pokemonDataReceived = [];
  try {
    for (int i = 0; i < limit; i++) {
      String url = 'https://pokeapi.co/api/v2/pokemon/${offset + i}';
      var response = await Dio().get(url);

      if (response.statusCode == 200){
        pokemonDataReceived.add(Pokemon.fromMap(response.data));
        return pokemonDataReceived;
      }
    }
  }
  catch (e,trace){
    print("[REST CLIENT] - getNextPokemons error $e\n$trace");
    return null;
  }
}