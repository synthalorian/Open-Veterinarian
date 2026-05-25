import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'pathology_detail_view.dart';

class PathologyListView extends StatelessWidget {
  const PathologyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final pathologies = DatabaseService.getPathologyBox().values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PATHOLOGY HUB'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pathologies.length,
        itemBuilder: (context, index) {
          final pathology = pathologies[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlowCard(
              glowColor: appColors.warning,
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PathologyDetailView(pathology: pathology)),
                ),
                leading: Icon(Icons.biotech, color: appColors.warning),
                title: Text(
                  pathology.name.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent, letterSpacing: 1.2),
                ),
                subtitle: Text(pathology.category, style: TextStyle(fontSize: 12, color: appColors.textDim)),
                trailing: Icon(Icons.chevron_right, color: appColors.warning, size: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}