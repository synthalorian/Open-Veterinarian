import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';

class OphthalmicHubView extends StatelessWidget {
  const OphthalmicHubView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final data = DatabaseService.getOphthalmicBox().values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('OPHTHALMIC HUB')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlowCard(
              glowColor: appColors.accent,
              child: ExpansionTile(
                leading: Icon(Icons.visibility, color: appColors.accent),
                title: Text(item.condition.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description, style: TextStyle(color: appColors.sectionHeader)),
                        const SizedBox(height: 12),
                        Text('IOP RANGE (TONOMETER)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.accent)),
                        Text(item.tonometerRange, style: const TextStyle(fontSize: 13, fontFamily: 'monospace')),
                        const SizedBox(height: 12),
                        Text('COMMON TREATMENTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.accent)),
                        ...item.commonTreatments.map((t) => Text('• $t', style: const TextStyle(fontSize: 13))),
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