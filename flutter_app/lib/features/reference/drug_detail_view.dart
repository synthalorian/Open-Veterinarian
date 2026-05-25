import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import 'data/drug_reference.dart';
import '../ui/glow_card.dart';

class DrugDetailView extends StatelessWidget {
  final DrugReference drug;

  const DrugDetailView({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(drug.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(appColors),
            const SizedBox(height: 24),
            _buildSectionTitle('Description', appColors),
            Text(
              drug.description,
              style: TextStyle(fontSize: 16, color: appColors.textDim, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Species Dosages', appColors),
            ...drug.speciesDosages.entries.map((e) => _buildDosageCard(e.key, e.value, appColors)),
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
            Icon(Icons.medication, size: 48, color: appColors.accent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drug.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appColors.accent),
                  ),
                  Text(
                    drug.category,
                    style: TextStyle(fontSize: 14, color: appColors.accent, letterSpacing: 1.2),
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

  Widget _buildDosageCard(String species, Dosage dosage, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlowCard(
        glowColor: appColors.accentSecondary,
        child: ListTile(
          leading: Icon(Icons.pets, color: appColors.accentSecondary),
          title: Text(
            species.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text('Range: ${dosage.min}-${dosage.max} ${dosage.unit}', style: TextStyle(color: appColors.textDim)),
              Text('Route: ${dosage.route} | Freq: ${dosage.frequency}', style: TextStyle(color: appColors.textDim)),
            ],
          ),
        ),
      ),
    );
  }
}