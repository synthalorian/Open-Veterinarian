import 'package:flutter/material.dart';
import '../ui/glow_card.dart';

class UnitConverterView extends StatefulWidget {
  const UnitConverterView({super.key});

  @override
  State<UnitConverterView> createState() => _UnitConverterViewState();
}

class _UnitConverterViewState extends State<UnitConverterView> {
  double lbs = 0;
  double kg = 0;
  double fahrenheit = 0;
  double celsius = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UNIT CONVERTER')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWeightConverter(),
          const SizedBox(height: 24),
          _buildTempConverter(),
        ],
      ),
    );
  }

  Widget _buildWeightConverter() {
    return GlowCard(
      glowColor: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('WEIGHT (LB ↔ KG)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'LB', border: OutlineInputBorder()),
                    onChanged: (val) {
                      double v = double.tryParse(val) ?? 0;
                      setState(() {
                        lbs = v;
                        kg = v / 2.20462;
                      });
                    },
                    controller: TextEditingController(text: lbs > 0 ? lbs.toStringAsFixed(2) : '')..selection = TextSelection.collapsed(offset: lbs.toStringAsFixed(2).length),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Icon(Icons.compare_arrows, color: Colors.blueAccent)),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'KG', border: OutlineInputBorder()),
                    onChanged: (val) {
                      double v = double.tryParse(val) ?? 0;
                      setState(() {
                        kg = v;
                        lbs = v * 2.20462;
                      });
                    },
                    controller: TextEditingController(text: kg > 0 ? kg.toStringAsFixed(2) : '')..selection = TextSelection.collapsed(offset: kg.toStringAsFixed(2).length),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTempConverter() {
    return GlowCard(
      glowColor: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TEMPERATURE (°F ↔ °C)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: '°F', border: OutlineInputBorder()),
                    onChanged: (val) {
                      double v = double.tryParse(val) ?? 0;
                      setState(() {
                        fahrenheit = v;
                        celsius = (v - 32) * 5 / 9;
                      });
                    },
                    controller: TextEditingController(text: fahrenheit > 0 ? fahrenheit.toStringAsFixed(1) : '')..selection = TextSelection.collapsed(offset: fahrenheit.toStringAsFixed(1).length),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Icon(Icons.compare_arrows, color: Colors.orangeAccent)),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: '°C', border: OutlineInputBorder()),
                    onChanged: (val) {
                      double v = double.tryParse(val) ?? 0;
                      setState(() {
                        celsius = v;
                        fahrenheit = (v * 9 / 5) + 32;
                      });
                    },
                    controller: TextEditingController(text: celsius > 0 ? celsius.toStringAsFixed(1) : '')..selection = TextSelection.collapsed(offset: celsius.toStringAsFixed(1).length),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
