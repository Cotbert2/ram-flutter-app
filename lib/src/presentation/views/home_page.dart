import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/character_viewmodel.dart';
import '../../domain/entities/character.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();

  final List<String> statusOptions = ["", "Alive", "Dead", "unknown"];
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CharacterViewModel>(context, listen: false).loadCharacters()
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Lógica para manejar la búsqueda
  void _performSearch(String name) {
    // Si la búsqueda no cambia, no hacer nada
    if (name == Provider.of<CharacterViewModel>(context, listen: false).currentSearchName) return;

    Provider.of<CharacterViewModel>(context, listen: false).updateSearchName(name);
  }

  void _onStatusChanged(String? status) {
    if (status != null) {
      Provider.of<CharacterViewModel>(context, listen: false).updateStatusFilter(status);
    }
  }


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CharacterViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Rick and Morty Characters")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search by name...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: _performSearch,
                    onChanged: (value) {
                    },
                  ),
                ),
                const SizedBox(width: 10),
                
                DropdownButton<String>(
                  value: vm.currentStatusFilter.isEmpty ? "" : vm.currentStatusFilter,
                  items: statusOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.isEmpty ? "All Statuses" : value),
                    );
                  }).toList(),
                  onChanged: _onStatusChanged,
                  hint: const Text("Filter by Status"),
                ),
              ],
            ),
          ),
          
          // Indicador de carga para paginación
          if (vm.loading && vm.characters.isNotEmpty)
            const LinearProgressIndicator(),
          
          if (vm.loading && vm.characters.isEmpty)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
          
          if (vm.errorMessage != null && vm.characters.isEmpty)
            Expanded(
              child: Center(
                child: Text(vm.errorMessage!),
              ),
            ),

          if (vm.characters.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: vm.characters.length,
                itemBuilder: (_, index) {
                  final Character p = vm.characters[index];
                  
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(p.imageUrl),
                      onBackgroundImageError: (e, s) => const Icon(Icons.person),
                    ),
                    title: Text(p.name),
                    subtitle: Text("${p.species} - Status: ${p.status}"),
                    trailing: Text("ID: ${p.id}"),
                    onTap: () {
                      // Navegar a la página de detalle, pasando el objeto Character
                      Navigator.pushNamed(context, "/detalle", arguments: p);
                    },
                  );
                },
              ),
            ),

          // Controles de paginación
          if (vm.characters.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: vm.hasPreviousPage && !vm.loading
                        ? () => vm.loadPreviousPage()
                        : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Anterior'),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Página ${vm.currentPage}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  
                  ElevatedButton.icon(
                    onPressed: vm.hasNextPage && !vm.loading
                        ? () => vm.loadNextPage()
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Siguiente'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}