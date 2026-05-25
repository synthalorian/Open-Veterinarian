import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';

class EcgLibraryView extends StatelessWidget {
  const EcgLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final data = DatabaseService.getEcgBox().values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('ECG LIBRARY')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlowCard(
              glowColor: appColors.danger,
              child: ExpansionTile(
                title: Text(item.rhythmName.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description, style: TextStyle(color: appColors.sectionHeader)),
                        const SizedBox(height: 12),
                        Text('CHARACTERISTICS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.danger)),
                        ...item.characteristics.map((c) => Text('• $c', style: const TextStyle(fontSize: 13))),
                        const SizedBox(height: 12),
                        Text('TREATMENT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.danger)),
                        Text(item.treatment, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
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