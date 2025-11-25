import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ram_flutter/main.dart';
import 'package:ram_flutter/src/data/datasources/character_datasource.dart';
import 'package:ram_flutter/src/data/repositories/character_repository_impl.dart';
import 'package:ram_flutter/src/domain/usecases/get_characters_usecase.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Crear las dependencias necesarias para el test
    final datasource = RickAndMortyDataSource();
    final repository = CharacterRepositoryImpl(datasource);
    final usecase = GetCharactersUseCase(repository);

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(usecase: usecase));

    // Verificar que la app se construye correctamente
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
