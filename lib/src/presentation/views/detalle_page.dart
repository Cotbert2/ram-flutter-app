import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Image of the character
              Image.network(
                character.imageUrl,
                width: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 200),
              ),
              const SizedBox(height: 20),

              Text(
                character.name.toUpperCase(),
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text("ID: ${character.id}", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 30),

              _buildInfoRow(
                  "Status", character.status, _getStatusColor(character.status)),
              _buildInfoRow("Species", character.species),
              _buildInfoRow("Gender", character.gender),
              _buildInfoRow("Type", character.type.isNotEmpty ? character.type : "N/A"),
              _buildInfoRow("Origin", character.originName),
              _buildInfoRow("Last Location", character.locationName),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text("$label:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 3,
            child: Text(value,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 18,
                  color: valueColor ?? Colors.black87,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      case 'unknown':
      default:
        return Colors.blueGrey;
    }
  }
}