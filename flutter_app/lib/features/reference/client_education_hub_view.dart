import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import '../ui/glow_card.dart';
import 'data/client_education.dart';

class ClientEducationHubView extends StatelessWidget {
  const ClientEducationHubView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    // In a real scenario, these would be fetched from Hive
    final diagrams = initialAnatomyDiagrams;

    return Scaffold(
      appBar: AppBar(title: const Text('CLIENT EDUCATION HUB')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: diagrams.length,
        itemBuilder: (context, index) {
          final item = diagrams[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlowCard(
              glowColor: appColors.accentSecondary,
              child: ExpansionTile(
                leading: Icon(Icons.menu_book, color: appColors.accentSecondary),
                title: Text(item.title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Placeholder for SVG/Image
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: appColors.card,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: appColors.accent.withAlpha(26)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, color: appColors.textDim, size: 48),
                                const SizedBox(height: 8),
                                Text('[ ${item.svgPath} ]', style: TextStyle(color: appColors.textDim, fontSize: 10, fontFamily: 'monospace')),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('EXPLANATION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.accentSecondary)),
                        const SizedBox(height: 4),
                        Text(item.explanation, style: TextStyle(color: appColors.sectionHeader, height: 1.4)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}