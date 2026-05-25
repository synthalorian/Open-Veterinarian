import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import '../ui/glow_card.dart';

class NeurologyHudView extends StatelessWidget {
  const NeurologyHudView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('NEUROLOGY HUD')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildChecklistSection('CRANIAL NERVES', [
            'CN I (Olfactory): Sniffing behavior',
            'CN II (Optic): Menace response, PLR',
            'CN III (Oculomotor): PLR, eye movement',
            'CN V (Trigeminal): Jaw tone, palpebral',
            'CN VII (Facial): Ear movement, lip tone',
            'CN VIII (Vestibulocochlear): Balance, nystagmus',
          ], appColors.accent),
          const SizedBox(height: 20),
          _buildChecklistSection('SPINAL REFLEXES', [
            'Patellar Reflex (Femoral N.): L4-L6',
            'Withdrawal Reflex (Sciatic N.): L6-S2',
            'Cutaneous Trunci Reflex: T2-L3',
            'Perineal Reflex (Pudendal N.): S1-S3',
          ], appColors.accentSecondary),
        ],
      ),
    );
  }

  Widget _buildChecklistSection(String title, List<String> items, Color color) {
    return GlowCard(
      glowColor: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, letterSpacing: 1.5)),
            Divider(color: color.withAlpha(26)),
            ...items.map((item) => CheckboxListTile(
              title: Text(item, style: const TextStyle(fontSize: 13)),
              value: false,
              onChanged: (v) {},
              activeColor: color,
              controlAffinity: ListTileControlAffinity.leading,
            )),
          ],
        ),
      ),
    );
  }
}