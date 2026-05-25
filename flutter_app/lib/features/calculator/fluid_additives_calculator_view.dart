import 'package:flutter/material.dart';
import '../ui/glow_card.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';

class FluidAdditivesCalculatorView extends StatefulWidget {
  const FluidAdditivesCalculatorView({super.key});

  @override
  State<FluidAdditivesCalculatorView> createState() => _FluidAdditivesCalculatorViewState();
}

class _FluidAdditivesCalculatorViewState extends State<FluidAdditivesCalculatorView> {
  double bagVolume = 1000; // ml
  double targetMeqPerL = 20; // mEq/L (Potassium)
  double stockConcentration = 2; // mEq/ml

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    // Math: [Target (mEq/L) * Bag Volume (L)] / Stock Conc (mEq/ml) = Volume to add (ml)
    double volumeToAdd = (targetMeqPerL * (bagVolume / 1000)) / stockConcentration;

    return Scaffold(
      appBar: AppBar(title: const Text('FLUID ADDITIVES')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInputSection(appColors),
          const SizedBox(height: 24),
          _buildResultSection(volumeToAdd, appColors),
        ],
      ),
    );
  }

  Widget _buildInputSection(AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildField('Fluid Bag Volume (ml)', (v) => bagVolume = v, initial: '1000'),
            _buildField('Target Conc (mEq/L)', (v) => targetMeqPerL = v, initial: '20'),
            _buildField('Stock Conc (mEq/ml)', (v) => stockConcentration = v, initial: '2'),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, Function(double) onChanged, {String initial = '0'}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        controller: TextEditingController(text: initial)..selection = TextSelection.collapsed(offset: initial.length),
        onChanged: (val) => setState(() => onChanged(double.tryParse(val) ?? 0)),
      ),
    );
  }

  Widget _buildResultSection(double result, AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('VOLUME TO ADD TO BAG', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: appColors.accent)),
            const SizedBox(height: 12),
            Text(
              '${result.toStringAsFixed(1)} ml',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }
}