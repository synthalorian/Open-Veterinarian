import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'data/ecg_reference.dart';

class EcgLibraryView extends StatelessWidget {
  const EcgLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
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
              glowColor: Colors.redAccent,
              child: ExpansionTile(
                title: Text(item.rhythmName.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description, style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 12),
                        const Text('CHARACTERISTICS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                        ...item.characteristics.map((c) => Text('• $c', style: const TextStyle(fontSize: 13))),
                        const SizedBox(height: 12),
                        const Text('TREATMENT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.redAccent)),
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
