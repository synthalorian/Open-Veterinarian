import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'data/imaging.dart';

class ImagingReferenceListView extends StatelessWidget {
  const ImagingReferenceListView({super.key});

  @override
  Widget build(BuildContext context) {
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
              glowColor: Colors.blueAccent,
              child: ExpansionTile(
                leading: Icon(item.category == 'X-Ray' ? Icons.settings_overscan : Icons.waves, color: Colors.blueAccent),
                title: Text(item.title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text(item.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('POSITIONING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                        const SizedBox(height: 4),
                        Text(item.positioning, style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 12),
                        const Text('CHECKLIST', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                        const SizedBox(height: 4),
                        ...item.checklist.map((c) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(children: [const Icon(Icons.check, size: 12, color: Colors.blueAccent), const SizedBox(width: 8), Expanded(child: Text(c, style: const TextStyle(fontSize: 13)))]),
                        )),
                        const SizedBox(height: 12),
                        const Text('CLINICAL NOTES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                        const SizedBox(height: 4),
                        Text(item.clinicalNotes, style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
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
