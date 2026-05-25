import 'package:flutter/material.dart';
import '../ui/glow_card.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';

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
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('UNIT CONVERTER')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWeightConverter(appColors),
          const SizedBox(height: 24),
          _buildTempConverter(appColors),
        ],
      ),
    );
  }

  Widget _buildWeightConverter(AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WEIGHT (LB \u2194 KG)', style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent)),
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
                Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Icon(Icons.compare_arrows, color: appColors.accent)),
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

  Widget _buildTempConverter(AppColors appColors) {
    return GlowCard(
      glowColor: appColors.warning,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TEMPERATURE (\u00b0F \u2194 \u00b0C)', style: TextStyle(fontWeight: FontWeight.bold, color: appColors.warning)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: '\u00b0F', border: OutlineInputBorder()),
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
                Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Icon(Icons.compare_arrows, color: appColors.warning)),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: '\u00b0C', border: OutlineInputBorder()),
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