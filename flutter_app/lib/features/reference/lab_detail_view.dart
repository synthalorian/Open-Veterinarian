import 'package:flutter/material.dart';
import 'data/lab_reference.dart';
import '../ui/glow_card.dart';

class LabDetailView extends StatelessWidget {
  final LabTest lab;

  const LabDetailView({super.key, required this.lab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lab.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionTitle('Reference Ranges'),
            ...lab.speciesRanges.entries.map((e) => _buildRangeCard(e.key, e.value)),
            const SizedBox(height: 24),
            _buildSectionTitle('Category'),
            Text(
              lab.category,
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
            const Icon(Icons.science, size: 48, color: Colors.cyanAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    '(${lab.abbreviation})',
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

  Widget _buildRangeCard(String species, LabRange range) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlowCard(
        glowColor: Colors.greenAccent,
        child: ListTile(
          leading: const Icon(Icons.pets, color: Colors.greenAccent),
          title: Text(
            species.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: Text(
            '${range.min} - ${range.max} ${range.unit}',
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
