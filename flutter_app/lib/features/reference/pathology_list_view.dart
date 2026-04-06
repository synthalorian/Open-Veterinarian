import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'pathology_detail_view.dart';

class PathologyListView extends StatelessWidget {
  const PathologyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final pathologies = DatabaseService.getPathologyBox().values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PATHOLOGY HUB'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pathologies.length,
        itemBuilder: (context, index) {
          final pathology = pathologies[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlowCard(
              glowColor: Colors.orangeAccent,
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PathologyDetailView(pathology: pathology)),
                ),
                leading: const Icon(Icons.biotech, color: Colors.orangeAccent),
                title: Text(
                  pathology.name.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                ),
                subtitle: Text(pathology.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right, color: Colors.orangeAccent, size: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
