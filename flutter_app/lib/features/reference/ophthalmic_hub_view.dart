import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';

class OphthalmicHubView extends StatelessWidget {
  const OphthalmicHubView({super.key});

  @override
  Widget build(BuildContext context) {
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
              glowColor: Colors.cyanAccent,
              child: ExpansionTile(
                leading: const Icon(Icons.visibility, color: Colors.cyanAccent),
                title: Text(item.condition.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description, style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 12),
                        const Text('IOP RANGE (TONOMETER)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                        Text(item.tonometerRange, style: const TextStyle(fontSize: 13, fontFamily: 'monospace')),
                        const SizedBox(height: 12),
                        const Text('COMMON TREATMENTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
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
