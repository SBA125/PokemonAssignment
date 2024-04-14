import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/pokemon_screen.dart';
import 'package:provider/provider.dart';
import 'model/pokemon.dart';
import 'provider/pokemon_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PokemonProvider>(
      create: (context) => PokemonProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Pokedex'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PokemonProvider>(context, listen: false).getAllPokemons();
    });
  }

  void _onClickingCard(BuildContext context, Pokemon pokemon) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return PokemonScreen(pokemon: pokemon);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 130,
        title: Container(
          padding: const EdgeInsets.fromLTRB(10, 80, 0, 0),
          child: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 97, 97, 97)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<PokemonProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const CircularProgressIndicator();
            } else {
              final pokemons = value.pokemons;
              return GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    pokemons.length,
                    (index) {
                      final pokemon = pokemons[index];
                      switch (pokemons[index].type.first) {
                        case "Fire":
                          bgColor = Colors.red;
                          break;
                        case "Grass":
                          bgColor = Colors.green.shade700;
                          break;
                        case "Normal":
                          bgColor = Colors.grey;
                          break;
                        case "Poison":
                          bgColor = Colors.purple;
                          break;
                        case "Electric":
                          bgColor = Colors.yellow;
                          break;
                        case "Water":
                          bgColor = Colors.blue;
                          break;
                        case "Ground":
                          bgColor = Colors.brown;
                          break;
                        case "Bug":
                          bgColor = Colors.green.shade200;
                          break;
                        case "Fighting":
                          bgColor = Colors.orange;
                          break;
                        case "Psychic":
                          bgColor = Colors.pink;
                          break;
                        case "Rock":
                          bgColor = Colors.brown.shade700;
                          break;
                        case "Ghost":
                          bgColor = Colors.deepPurple.shade700;
                          break;
                        case "Ice":
                          bgColor = Colors.lightBlueAccent;
                          break;
                        case "Dragon":
                          bgColor = Colors.indigo.shade900;
                          break;
                        case "Fairy":
                          bgColor = Colors.pinkAccent;
                          break;
                        default:
                          bgColor = Colors.white; // Default color
                          break;
                      }
                      return GestureDetector(
                        onTap: () {
                          _onClickingCard(context, pokemon);
                        },
                        child: Card(
                          color: bgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Stack(
                            children: [
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(8, 20, 4, 0),
                                title: Text(
                                  pokemons[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 90, 0),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        )),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      pokemons[index].type.first,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  top: 30,
                                  left: 60,
                                  child: Image.network(
                                    pokemons[index].img,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ));
            }
          },
        ),
      ),
    );
  }
}
