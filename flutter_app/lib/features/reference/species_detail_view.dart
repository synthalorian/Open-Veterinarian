import 'package:flutter/material.dart';
import 'data/species_vitals.dart';
import '../ui/glow_card.dart';

class SpeciesDetailView extends StatelessWidget {
  final SpeciesVitals species;

  const SpeciesDetailView({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(species.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionTitle('Normal Reference Ranges'),
            _buildVitalRow(Icons.thermostat, 'Temperature', species.temperature.toString()),
            _buildVitalRow(Icons.favorite, 'Heart Rate', species.heartRate.toString()),
            _buildVitalRow(Icons.air, 'Respiratory Rate', species.respiratoryRate.toString()),
            const SizedBox(height: 24),
            _buildSectionTitle('About'),
            Text(
              '${species.name} (${species.scientificName}) is a standard reference for clinical assessment. These ranges are intended for baseline screening in resting, non-stressed patients.',
              style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GlowCard(
      glowColor: Colors.cyanAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            const Icon(Icons.pets, size: 48, color: Colors.cyanAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    species.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    species.scientificName,
                    style: const TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildVitalRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlowCard(
        glowColor: Colors.blueAccent,
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          trailing: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Colors.cyanAccent,
            ),
          ),
        ),
      ),
    );
  }
}
