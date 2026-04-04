import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'data/triage.dart';

class TriageHudView extends StatelessWidget {
  const TriageHudView({super.key});

  @override
  Widget build(BuildContext context) {
    final triageCriteria = DatabaseService.getTriageBox().values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('EMERGENCY TRIAGE HUD')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: triageCriteria.length,
        itemBuilder: (context, index) {
          final item = triageCriteria[index];
          Color urgencyColor = item.urgency == 'Critical' ? Colors.redAccent : Colors.orangeAccent;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlowCard(
              glowColor: urgencyColor,
              child: ExpansionTile(
                leading: Text(item.category.split(' ').first, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: urgencyColor)),
                title: Text(item.category.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text(item.urgency, style: TextStyle(fontSize: 12, color: urgencyColor, fontWeight: FontWeight.bold)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description, style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 12),
                        const Text('INDICATORS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                        const SizedBox(height: 4),
                        ...item.indicators.map((i) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(children: [const Icon(Icons.warning_amber, size: 14, color: Colors.orangeAccent), const SizedBox(width: 8), Expanded(child: Text(i, style: const TextStyle(fontSize: 13)))]),
                        )),
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
