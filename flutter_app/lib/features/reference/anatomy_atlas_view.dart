import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'data/anatomy.dart';

class AnatomyAtlasView extends StatelessWidget {
  const AnatomyAtlasView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DatabaseService.getAnatomyBox().values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('ANATOMY ATLAS')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlowCard(
              glowColor: Colors.greenAccent,
              child: ExpansionTile(
                title: Text(item.partName.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text(item.system, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description, style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 12),
                        const Text('CLINICAL SIGNIFICANCE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                        ...item.clinicalSignificance.map((s) => Text('• $s', style: const TextStyle(fontSize: 13))),
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
