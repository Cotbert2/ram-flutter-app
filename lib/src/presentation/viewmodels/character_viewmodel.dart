import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters_usecase.dart';

class CharacterViewModel extends ChangeNotifier {
  final GetCharactersUseCase getCharacters;

  CharacterViewModel(this.getCharacters);

  List<Character> characters = [];
  bool loading = false;
  String? errorMessage;
  
  
  int currentPage = 1;
  String currentStatusFilter = "";
  String currentSearchName = "";
  bool hasNextPage = true;
  bool hasPreviousPage = false; 

  
  Future<void> loadCharacters({
    bool isNewSearch = false, 
  }) async {

    if (loading) return;
    loading = true;
    notifyListeners();

    if (isNewSearch) {
      currentPage = 1;
      characters = [];
    }

    try {
      final newCharacters = await getCharacters(
        page: currentPage,
        name: currentSearchName,
        status: currentStatusFilter,
      );

      characters = newCharacters; // Reemplazar en lugar de agregar
      
      // Determinar si hay más páginas
      hasNextPage = newCharacters.length == 20; // API devuelve 20 personajes por página
      hasPreviousPage = currentPage > 1;

      errorMessage = null;

    } catch (e) {
      errorMessage = "Error al cargar los personajes. Intenta de nuevo.";
      characters = []; 
      hasNextPage = false;
      hasPreviousPage = currentPage > 1;
    }

    loading = false;
    notifyListeners();
  }
  

  void updateStatusFilter(String status) {
    currentStatusFilter = status;
    loadCharacters(isNewSearch: true); 
  }

  void updateSearchName(String name) {
    currentSearchName = name;
    loadCharacters(isNewSearch: true); 
  }

  Future<void> loadNextPage() async {
    if (hasNextPage && !loading) {
      currentPage++;
      await loadCharacters();
    }
  }

  Future<void> loadPreviousPage() async {
    if (hasPreviousPage && !loading) {
      currentPage--;
      await loadCharacters();
    }
  }
}