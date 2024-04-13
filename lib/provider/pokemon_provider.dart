import 'package:flutter/material.dart';
import '../model/pokemon.dart';
import '../service/pokemon_service.dart';

class PokemonProvider extends ChangeNotifier {
  final _service = PokemonService();
  bool isLoading = true;
  List<Pokemon> _pokemons = [];
  List<Pokemon> get pokemons => _pokemons;

  Future<void> getAllPokemons() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAllPokemons();

    _pokemons = response;
    isLoading = false;
    notifyListeners();
  }
}
