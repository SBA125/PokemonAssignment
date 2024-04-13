import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/pokemon.dart';

class PokemonService {
  Future<List<Pokemon>> getAllPokemons() async {
    final response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"));
    print(response.statusCode);

    if (response.statusCode == 200) {
      final List<dynamic> pokemonDataList =
          jsonDecode(response.body)['pokemon'];
      List<Pokemon> pokemonList = pokemonDataList.map((e) {
        // Create Pokemon object
        return Pokemon.fromJson(e);
      }).toList();
      return pokemonList;
    } else {
      throw Exception('Failed to load Pokemon list');
    }
  }
}
