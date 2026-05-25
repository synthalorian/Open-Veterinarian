import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import 'data/pathology.dart';
import '../ui/glow_card.dart';

class PathologyDetailView extends StatelessWidget {
  final Pathology pathology;

  const PathologyDetailView({super.key, required this.pathology});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(pathology.name.toUpperCase()),
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
              pathology.description,
              style: TextStyle(fontSize: 16, color: appColors.textDim, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Clinical Signs', appColors),
            ...pathology.clinicalSigns.map((sign) => _buildBulletPoint(sign, appColors)),
            const SizedBox(height: 24),
            _buildSectionTitle('Diagnostic Steps', appColors),
            ...pathology.diagnosticSteps.map((step) => _buildBulletPoint(step, appColors)),
            const SizedBox(height: 24),
            _buildSectionTitle('Management Summary', appColors),
            GlowCard(
              glowColor: appColors.warning,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  pathology.managementSummary,
                  style: TextStyle(fontSize: 14, color: appColors.accent, height: 1.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppColors appColors) {
    return GlowCard(
      glowColor: appColors.warning,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(Icons.biotech, size: 48, color: appColors.warning),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pathology.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appColors.accent),
                  ),
                  Text(
                    pathology.category,
                    style: TextStyle(fontSize: 14, color: appColors.warning, letterSpacing: 1.2),
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

  Widget _buildBulletPoint(String text, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: appColors.warning, fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: appColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}