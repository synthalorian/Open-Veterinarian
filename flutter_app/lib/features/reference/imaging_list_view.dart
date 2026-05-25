import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';

class ImagingReferenceListView extends StatelessWidget {
  const ImagingReferenceListView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final imagingData = DatabaseService.getImagingBox().values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('IMAGING HUB'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: imagingData.length,
        itemBuilder: (context, index) {
          final item = imagingData[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlowCard(
              glowColor: appColors.accentSecondary,
              child: ExpansionTile(
                leading: Icon(item.category == 'X-Ray' ? Icons.settings_overscan : Icons.waves, color: appColors.accentSecondary),
                title: Text(item.title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent)),
                subtitle: Text(item.category, style: TextStyle(fontSize: 12, color: appColors.textDim)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('POSITIONING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.accentSecondary)),
                        const SizedBox(height: 4),
                        Text(item.positioning, style: TextStyle(color: appColors.accent)),
                        const SizedBox(height: 12),
                        Text('CHECKLIST', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.accentSecondary)),
                        const SizedBox(height: 4),
                        ...item.checklist.map((c) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(children: [Icon(Icons.check, size: 12, color: appColors.accentSecondary), const SizedBox(width: 8), Expanded(child: Text(c, style: const TextStyle(fontSize: 13)))]),
                        )),
                        const SizedBox(height: 12),
                        Text('CLINICAL NOTES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.accentSecondary)),
                        const SizedBox(height: 4),
                        Text(item.clinicalNotes, style: TextStyle(fontSize: 12, color: appColors.textDim, fontStyle: FontStyle.italic)),
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