import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  static Future<Map<String, dynamic>?> fetchPokemon(String name) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Error al obtener datos: ${response.statusCode}");
      }
    } catch (e) {
      print("Error en la petición: $e");
    }

    return null;
  }
}
