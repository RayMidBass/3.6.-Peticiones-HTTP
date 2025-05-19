import 'package:flutter/material.dart';
import 'pokemon_service.dart';

void main() {
  runApp(PokeApp());
}

class PokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Info',
      home: PokemonHome(),
    );
  }
}

class PokemonHome extends StatefulWidget {
  @override
  _PokemonHomeState createState() => _PokemonHomeState();
}

class _PokemonHomeState extends State<PokemonHome> {
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;

  void _fetchData() async {
    setState(() => isLoading = true);
    final data = await PokemonService.fetchPokemon('pikachu');
    setState(() {
      pokemonData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokémon Info')),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : pokemonData != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(pokemonData!['sprites']['front_default']),
                      Text(
                        pokemonData!['name'].toString().toUpperCase(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text('Altura: ${pokemonData!['height']}'),
                      Text('Peso: ${pokemonData!['weight']}'),
                    ],
                  )
                : Text('No se pudo cargar la información'),
      ),
    );
  }
}
