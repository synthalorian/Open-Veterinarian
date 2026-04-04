import 'package:flutter/material.dart';
import 'data/drug_reference.dart';
import '../ui/glow_card.dart';

class DrugDetailView extends StatelessWidget {
  final DrugReference drug;

  const DrugDetailView({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drug.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            Text(
              drug.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Species Dosages'),
            ...drug.speciesDosages.entries.map((e) => _buildDosageCard(e.key, e.value)),
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
            const Icon(Icons.medication, size: 48, color: Colors.cyanAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drug.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    drug.category,
                    style: const TextStyle(fontSize: 14, color: Colors.cyanAccent, letterSpacing: 1.2),
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

  Widget _buildDosageCard(String species, Dosage dosage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlowCard(
        glowColor: Colors.purpleAccent,
        child: ListTile(
          leading: const Icon(Icons.pets, color: Colors.purpleAccent),
          title: Text(
            species.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text('Range: ${dosage.min}-${dosage.max} ${dosage.unit}', style: const TextStyle(color: Colors.grey)),
              Text('Route: ${dosage.route} | Freq: ${dosage.frequency}', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
