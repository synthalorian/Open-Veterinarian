import 'package:flutter/material.dart';
import '../ui/glow_card.dart';

class ClientEducationView extends StatelessWidget {
  const ClientEducationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CLIENT EDUCATION')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEducationSection(
            'Common Conditions',
            [
              _EducationTopic('Feline Dental Disease', 'Understanding resorption and gingivitis.'),
              _EducationTopic('Canine Osteoarthritis', 'Managing joint pain and mobility.'),
              _EducationTopic('Vaccination Schedules', 'Why core vaccines matter.'),
            ],
            Colors.greenAccent,
          ),
          const SizedBox(height: 24),
          _buildEducationSection(
            'Anatomy 101',
            [
              _EducationTopic('The Canine Heart', 'Visualizing the 4 chambers and valves.'),
              _EducationTopic('The Feline Kidney', 'Understanding filtration and CKD.'),
              _EducationTopic('Digestive Tract', 'From esophagus to colon.'),
            ],
            Colors.blueAccent,
          ),
          const SizedBox(height: 24),
          _buildEducationSection(
            'Preventative Care',
            [
              _EducationTopic('Heartworm Prevention', 'The lifecycle of Dirofilaria immitis.'),
              _EducationTopic('Nutrition & Weight', 'Caloric needs and BCS scores.'),
            ],
            Colors.purpleAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection(String title, List<_EducationTopic> topics, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2.0, color: color),
        ),
        const SizedBox(height: 12),
        ...topics.map((topic) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlowCard(
            glowColor: color,
            child: ListTile(
              onTap: () {
                // Future: Launch URL or show internal PDF/Image
              },
              leading: Icon(Icons.menu_book, color: color),
              title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text(topic.subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            ),
          ),
        )),
      ],
    );
  }
}

class _EducationTopic {
  final String title;
  final String subtitle;
  _EducationTopic(this.title, this.subtitle);
}
