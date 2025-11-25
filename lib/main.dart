import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importaciones de la capa de Data
import 'src/data/datasources/character_datasource.dart';
import 'src/data/repositories/character_repository_impl.dart';

// Importaciones de la capa de Domain
import 'src/domain/usecases/get_characters_usecase.dart';

// Importaciones de la capa de Presentation
import 'src/presentation/viewmodels/character_viewmodel.dart';
import 'src/presentation/routes/app_routes.dart';

void main() {
  // 1. Inicialización de la cadena de dependencias (DI)
  final datasource = RickAndMortyDataSource();
  final repository = CharacterRepositoryImpl(datasource);
  final usecase = GetCharactersUseCase(repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  final GetCharactersUseCase usecase;

  const MyApp({super.key, required this.usecase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Inyección del ViewModel
        ChangeNotifierProvider(
          create: (_) => CharacterViewModel(usecase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Usamos las rutas definidas en AppRoutes
        routes: AppRoutes.routes,
        initialRoute: "/splash",
        theme: ThemeData(
          colorSchemeSeed: Colors.green, // Tema adaptado a Rick and Morty
          useMaterial3: true,
        ),
      ),
    );
  }
}