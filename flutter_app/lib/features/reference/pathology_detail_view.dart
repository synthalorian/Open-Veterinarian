import 'package:flutter/material.dart';
import 'data/pathology.dart';
import '../ui/glow_card.dart';

class PathologyDetailView extends StatelessWidget {
  final Pathology pathology;

  const PathologyDetailView({super.key, required this.pathology});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pathology.name.toUpperCase()),
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
              pathology.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Clinical Signs'),
            ...pathology.clinicalSigns.map((sign) => _buildBulletPoint(sign)),
            const SizedBox(height: 24),
            _buildSectionTitle('Diagnostic Steps'),
            ...pathology.diagnosticSteps.map((step) => _buildBulletPoint(step)),
            const SizedBox(height: 24),
            _buildSectionTitle('Management Summary'),
            GlowCard(
              glowColor: Colors.orangeAccent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  pathology.managementSummary,
                  style: const TextStyle(fontSize: 14, color: Colors.white, height: 1.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GlowCard(
      glowColor: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            const Icon(Icons.biotech, size: 48, color: Colors.orangeAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pathology.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    pathology.category,
                    style: const TextStyle(fontSize: 14, color: Colors.orangeAccent, letterSpacing: 1.2),
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
