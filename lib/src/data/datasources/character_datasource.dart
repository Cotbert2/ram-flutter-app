import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class RickAndMortyDataSource {
  final String baseUrl = "https://rickandmortyapi.com/api/character";

  Future<List<CharacterModel>> fetchCharacters({
    int page = 1,
    String? name,
    String? status,
  }) async {

    final Map<String, dynamic> queryParameters = {
      'page': page.toString(),

      if (name != null && name.isNotEmpty) 'name': name,
      if (status != null && status.isNotEmpty) 'status': status,
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw Exception("Error fetching characters: ${resp.statusCode}. URL: $uri");
    }


    final data = jsonDecode(resp.body);
    
    final List results = data["results"]; 

    return results.map((e) => CharacterModel.fromJson(e)).toList();
  }
}