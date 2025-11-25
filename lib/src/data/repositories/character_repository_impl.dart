import '../../domain/entities/character.dart';
import '../datasources/character_datasource.dart';

class CharacterRepositoryImpl {
  final RickAndMortyDataSource datasource;

  CharacterRepositoryImpl(this.datasource);

  Future<List<Character>> getCharacters({
    int page = 1,
    String? name,
    String? status,
  }) async {
    return datasource.fetchCharacters(
      page: page,
      name: name,
      status: status,
    );
  }
}