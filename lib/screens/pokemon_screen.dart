import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/pokemon.dart';

class PokemonScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonScreen({super.key, required this.pokemon});

  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // No need to use showModalBottomSheet or showBottomSheet here
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height / 1.75;
    Color bg_color;

    switch (widget.pokemon.type.first) {
      case "Fire":
        bg_color = Colors.red;
        break;
      case "Grass":
        bg_color = Colors.green.shade700;
        break;
      case "Normal":
        bg_color = Colors.grey;
        break;
      case "Poison":
        bg_color = Colors.purple;
        break;
      case "Electric":
        bg_color = Colors.yellow;
        break;
      case "Water":
        bg_color = Colors.blue;
        break;
      case "Ground":
        bg_color = Colors.brown;
        break;
      case "Bug":
        bg_color = Colors.green.shade200;
        break;
      case "Fighting":
        bg_color = Colors.orange;
        break;
      case "Psychic":
        bg_color = Colors.pink;
        break;
      case "Rock":
        bg_color = Colors.brown.shade700;
        break;
      case "Ghost":
        bg_color = Colors.deepPurple.shade700;
        break;
      case "Ice":
        bg_color = Colors.lightBlueAccent;
        break;
      case "Dragon":
        bg_color = Colors.indigo.shade900;
        break;
      case "Fairy":
        bg_color = Colors.pinkAccent;
        break;
      default:
        bg_color = Colors.white; // Default color
        break;
    }
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: bg_color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Pokedex'),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.pokemon.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              const Spacer(), // This will occupy the available space
              Text(
                "#${widget.pokemon.id}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 10), // Adjust this width as needed
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.pokemon.type.first,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.network(
              widget.pokemon.img,
              height: 250,
            )
          ])
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.white),
        width: screenWidth,
        height: screenHeight,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Name'),
                const SizedBox(width: 70),
                Text(widget.pokemon.name),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Height'),
                const SizedBox(width: 66),
                Text(widget.pokemon.height),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Weight'),
                const SizedBox(width: 64),
                Text(widget.pokemon.weight),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Spawn Time'),
                const SizedBox(width: 30),
                Text(widget.pokemon.spawnTime.toString()),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Weaknesses'),
                const SizedBox(width: 28),
                Text(
                  widget.pokemon.weaknesses.join(', '),
                ), // Replace with actual weaknesses
              ],
            ),
            if (widget.pokemon.prevEvolution?.isNotEmpty == true)
              Row(
                children: [
                  const Text('Pre Evolution'),
                  const SizedBox(width: 24),
                  Text(
                    widget.pokemon.prevEvolution!
                        .map((e) => e.name)
                        .join(', '), // Replace with actual pre-evolution
                  ),
                ],
              ),
            if (widget.pokemon.prevEvolution == null &&
                widget.pokemon.nextEvolution?.isNotEmpty == true)
              const SizedBox(height: 12),
            if (widget.pokemon.nextEvolution?.isNotEmpty == true)
              Row(
                children: [
                  const Text('Next Evolution'),
                  const SizedBox(width: 16),
                  Text(
                    widget.pokemon.nextEvolution!
                        .map((e) => e.name)
                        .join(', '), // Replace with actual next-evolution
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
