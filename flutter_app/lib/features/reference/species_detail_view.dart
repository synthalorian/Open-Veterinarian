import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import 'data/species_vitals.dart';
import '../ui/glow_card.dart';

class SpeciesDetailView extends StatelessWidget {
  final SpeciesVitals species;

  const SpeciesDetailView({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(species.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(appColors),
            const SizedBox(height: 24),
            _buildSectionTitle('Normal Reference Ranges', appColors),
            _buildVitalRow(Icons.thermostat, 'Temperature', species.temperature.toString(), appColors),
            _buildVitalRow(Icons.favorite, 'Heart Rate', species.heartRate.toString(), appColors),
            _buildVitalRow(Icons.air, 'Respiratory Rate', species.respiratoryRate.toString(), appColors),
            const SizedBox(height: 24),
            _buildSectionTitle('About', appColors),
            Text(
              '${species.name} (${species.scientificName}) is a standard reference for clinical assessment. These ranges are intended for baseline screening in resting, non-stressed patients.',
              style: TextStyle(fontSize: 16, color: appColors.textDim, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(Icons.pets, size: 48, color: appColors.accent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    species.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appColors.accent),
                  ),
                  Text(
                    species.scientificName,
                    style: TextStyle(fontSize: 14, color: appColors.textDim, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: appColors.sectionHeader,
        ),
      ),
    );
  }

  Widget _buildVitalRow(IconData icon, String label, String value, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlowCard(
        glowColor: appColors.accentSecondary,
        child: ListTile(
          leading: Icon(icon, color: appColors.accentSecondary),
          title: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent)),
          trailing: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: appColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}