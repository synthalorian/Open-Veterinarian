import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'anesthesia_protocols.dart';

class AnesthesiaProtocolsView extends StatelessWidget {
  const AnesthesiaProtocolsView({super.key});

  @override
  Widget build(BuildContext context) {
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
          return _buildProtocolCard(protocol);
        },
      ),
    );
  }

  Widget _buildProtocolCard(AnesthesiaProtocol protocol) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlowCard(
        glowColor: Colors.purpleAccent,
        child: ExpansionTile(
          iconColor: Colors.purpleAccent,
          collapsedIconColor: Colors.grey,
          title: Text(
            protocol.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
          ),
          subtitle: Text(
            protocol.indications,
            style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    protocol.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.purpleAccent, thickness: 0.5),
                  const SizedBox(height: 8),
                  ...protocol.drugs.entries.map((e) => _buildDrugRow(e.key, e.value)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrugRow(String phase, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              phase.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.purpleAccent, letterSpacing: 1.0),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              details,
              style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
