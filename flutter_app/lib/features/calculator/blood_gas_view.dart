import 'package:flutter/material.dart';
import 'blood_gas_interpreter.dart';
import '../ui/glow_card.dart';

class BloodGasInterpreterView extends StatefulWidget {
  const BloodGasInterpreterView({super.key});

  @override
  State<BloodGasInterpreterView> createState() => _BloodGasInterpreterViewState();
}

class _BloodGasInterpreterViewState extends State<BloodGasInterpreterView> {
  double ph = 7.4;
  double pco2 = 40;
  double hco3 = 22;

  @override
  Widget build(BuildContext context) {
    final result = BloodGasInterpreter.interpret(ph: ph, pco2: pco2, hco3: hco3);

    return Scaffold(
      appBar: AppBar(title: const Text('BLOOD GAS INTERPRETER')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputSection(),
            const SizedBox(height: 24),
            _buildResultSection(result),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return GlowCard(
      glowColor: Colors.cyanAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSlider('pH', ph, 6.8, 7.8, (v) => setState(() => ph = v)),
            _buildSlider('pCO2 (mmHg)', pco2, 10, 80, (v) => setState(() => pco2 = v)),
            _buildSlider('HCO3 (mEq/L)', hco3, 5, 45, (v) => setState(() => hco3 = v)),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value.toStringAsFixed(2), style: const TextStyle(fontFamily: 'monospace', color: Colors.cyanAccent)),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.cyanAccent,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildResultSection(BloodGasResult res) {
    return GlowCard(
      glowColor: res.primaryDisturbance == 'Normal' ? Colors.greenAccent : Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('INTERPRETATION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            Text(
              res.primaryDisturbance.toUpperCase(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              res.compensation,
              style: TextStyle(fontSize: 14, color: Colors.grey[400], fontStyle: FontStyle.italic),
            ),
            const Divider(height: 24, color: Colors.white10),
            Text(
              res.interpretation,
              style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
