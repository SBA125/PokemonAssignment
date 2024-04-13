import 'package:flutter/material.dart';
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

  void _showTodoDetails(BuildContext context, Pokemon pokemon) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double screen_width = MediaQuery.of(context).size.width;
        return Container(
          width: screen_width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${pokemon.id}'),
              Text('Name: ${pokemon.name}'),
              Text('Height: ${pokemon.height}')
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      return Card(
                        child: ListTile(
                          title: Text(pokemons[index].name),
                          subtitle: Text(
                            pokemons[index].weaknesses.first,
                          ),
                          trailing: Image.network(
                            pokemons[index].img,
                          ),
                          onTap: () {
                            _showTodoDetails(context, pokemon);
                          },
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
