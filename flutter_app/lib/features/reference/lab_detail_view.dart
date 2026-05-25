import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import 'data/lab_reference.dart';
import '../ui/glow_card.dart';

class LabDetailView extends StatelessWidget {
  final LabTest lab;

  const LabDetailView({super.key, required this.lab});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(lab.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(appColors),
            const SizedBox(height: 24),
            _buildSectionTitle('Reference Ranges', appColors),
            ...lab.speciesRanges.entries.map((e) => _buildRangeCard(e.key, e.value, appColors)),
            const SizedBox(height: 24),
            _buildSectionTitle('Category', appColors),
            Text(
              lab.category,
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
            Icon(Icons.science, size: 48, color: appColors.accent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appColors.accent),
                  ),
                  Text(
                    '(${lab.abbreviation})',
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

  Widget _buildRangeCard(String species, LabRange range, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlowCard(
        glowColor: appColors.success,
        child: ListTile(
          leading: Icon(Icons.pets, color: appColors.success),
          title: Text(
            species.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent),
          ),
          trailing: Text(
            '${range.min} - ${range.max} ${range.unit}',
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