import 'package:flutter/material.dart';
import 'data/species_vitals.dart';
import '../ui/species_icons.dart';
import 'species_detail_view.dart';

class SpeciesVitalsView extends StatelessWidget {
  const SpeciesVitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Species Vitals Reference'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: initialVitalsData.length,
        itemBuilder: (context, index) {
          final species = initialVitalsData[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SpeciesDetailView(species: species))),
              leading: SpeciesIcon(species: species.name, size: 28),
              title: Text(species.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(species.scientificName, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey)),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
