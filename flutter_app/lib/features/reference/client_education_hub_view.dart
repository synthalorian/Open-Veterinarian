import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'data/client_education.dart';

class ClientEducationHubView extends StatelessWidget {
  const ClientEducationHubView({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real scenario, these would be fetched from Hive
    final diagrams = initialAnatomyDiagrams;

    return Scaffold(
      appBar: AppBar(title: const Text('CLIENT EDUCATION HUB')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: diagrams.length,
        itemBuilder: (context, index) {
          final item = diagrams[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlowCard(
              glowColor: Colors.tealAccent,
              child: ExpansionTile(
                leading: const Icon(Icons.menu_book, color: Colors.tealAccent),
                title: Text(item.title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Placeholder for SVG/Image
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.image, color: Colors.grey, size: 48),
                                const SizedBox(height: 8),
                                Text('[ ${item.svgPath} ]', style: const TextStyle(color: Colors.grey, fontSize: 10, fontFamily: 'monospace')),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('EXPLANATION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.tealAccent)),
                        const SizedBox(height: 4),
                        Text(item.explanation, style: const TextStyle(color: Colors.white70, height: 1.4)),
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
