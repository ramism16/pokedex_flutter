import 'package:dio/dio.dart';
import 'models/pokemon.dart';

Future<List<Pokemon>?>? getNextPokemons(int limit, int offset) async {
  List<Pokemon> pokemonDataReceived = [];
  try {
    for (int i = 1; i <= limit; i++) {
      String url = 'https://pokeapi.co/api/v2/pokemon/${offset + i}';
      var response = await Dio().get(url);

      if (response.statusCode == 200){
        pokemonDataReceived.add(Pokemon.fromMap(response.data));

      }
    }
    return pokemonDataReceived;
  }
  catch (e,trace){
    print("[REST CLIENT] - getNextPokemons error $e\n$trace");
    return null;
  }
}

Future<List<Pokemon>?>? getFavouritePokemons(List<int> ids) async {
  List<Pokemon> pokemonDataReceived = [];
  try{
    if (ids.isEmpty)
      return pokemonDataReceived;
    for (int id in ids){
      String url = 'https://pokeapi.co/api/v2/pokemon/${id}';
      var response = await Dio().get(url);

      if (response.statusCode == 200){
        pokemonDataReceived.add(Pokemon.fromMap(response.data));

      }
    }
    return pokemonDataReceived;
  }
  catch (e,trace){
    print("[REST CLIENT] - getFavouritePokemons error $e\n$trace");
    return null;
  }
}