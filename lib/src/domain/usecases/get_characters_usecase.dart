

import '../entities/character.dart';
import '../../data/repositories/character_repository_impl.dart';

class GetCharactersUseCase {
  final CharacterRepositoryImpl repository;

  GetCharactersUseCase(this.repository);


  Future<List<Character>> call({
    int page = 1,
    String? name,
    String? status,
  }) {
    return repository.getCharacters(
      page: page,
      name: name,
      status: status,
    );
  }
}