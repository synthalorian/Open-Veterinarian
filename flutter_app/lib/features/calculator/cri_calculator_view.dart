import 'package:flutter/material.dart';
import '../ui/glow_card.dart';

class CriCalculatorView extends StatefulWidget {
  const CriCalculatorView({super.key});

  @override
  State<CriCalculatorView> createState() => _CriCalculatorViewState();
}

class _CriCalculatorViewState extends State<CriCalculatorView> {
  double weight = 0;
  double doseRate = 0; // mcg/kg/min
  double concentration = 0; // mg/ml
  double fluidRate = 0; // ml/hr

  @override
  Widget build(BuildContext context) {
    // Math: [Dose (mcg/kg/min) * Weight (kg) * 60] / [Concentration (mg/ml) * 1000] = CRI Rate (ml/hr)
    double criResult = 0;
    if (weight > 0 && doseRate > 0 && concentration > 0) {
      criResult = (doseRate * weight * 60) / (concentration * 1000);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('CRI CALCULATOR')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInputSection(),
          const SizedBox(height: 24),
          if (criResult > 0) _buildResultSection(criResult),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return GlowCard(
      glowColor: Colors.purpleAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildField('Weight (kg)', (v) => weight = v),
            _buildField('Dose Rate (mcg/kg/min)', (v) => doseRate = v),
            _buildField('Drug Concentration (mg/ml)', (v) => concentration = v),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        onChanged: (val) => setState(() => onChanged(double.tryParse(val) ?? 0)),
      ),
    );
  }

  Widget _buildResultSection(double result) {
    return GlowCard(
      glowColor: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('CALCULATED INFUSION RATE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
            const SizedBox(height: 12),
            Text(
              '${result.toStringAsFixed(2)} ml/hr',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }
}
