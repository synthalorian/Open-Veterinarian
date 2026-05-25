import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../theme/app_theme.dart';
import '../ui/glow_card.dart';
import 'anesthesia_protocols.dart';

class AnesthesiaProtocolsView extends StatelessWidget {
  const AnesthesiaProtocolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final protocols = DatabaseService.getProtocolsBox().values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ANESTHESIA PROTOCOLS'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: protocols.length,
        itemBuilder: (context, index) {
          final protocol = protocols[index];
          return _buildProtocolCard(protocol, appColors);
        },
      ),
    );
  }

  Widget _buildProtocolCard(AnesthesiaProtocol protocol, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlowCard(
        glowColor: appColors.accent,
        child: ExpansionTile(
          iconColor: appColors.accent,
          collapsedIconColor: appColors.textDim,
          title: Text(
            protocol.name.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent.withAlpha(204), letterSpacing: 1.2),
          ),
          subtitle: Text(
            protocol.indications,
            style: TextStyle(fontSize: 12, color: appColors.textDim, fontStyle: FontStyle.italic),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    protocol.description,
                    style: TextStyle(fontSize: 14, color: appColors.sectionHeader, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: appColors.accent, thickness: 0.5),
                  const SizedBox(height: 8),
                  ...protocol.drugs.entries.map((e) => _buildDrugRow(e.key, e.value, appColors)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrugRow(String phase, String details, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              phase.toUpperCase(),
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.accent, letterSpacing: 1.0),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              details,
              style: TextStyle(fontSize: 13, color: appColors.accent.withAlpha(204), height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
