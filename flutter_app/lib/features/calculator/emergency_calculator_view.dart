import 'dart:async';
import 'package:flutter/material.dart';
import 'emergency_drug_data.dart';
import '../ui/glow_card.dart';

class EmergencyCalculatorView extends StatefulWidget {
  const EmergencyCalculatorView({super.key});

  @override
  State<EmergencyCalculatorView> createState() => _EmergencyCalculatorViewState();
}

class _EmergencyCalculatorViewState extends State<EmergencyCalculatorView> {
  double weight = 0;
  bool metronomeActive = false;
  Timer? _metronomeTimer;
  int _beatCount = 0;

  void _toggleMetronome() {
    setState(() {
      metronomeActive = !metronomeActive;
      if (metronomeActive) {
        // CPR rate: 100-120 bpm. We'll go with 110.
        // 60,000 ms / 110 bpm = ~545ms per beat
        _metronomeTimer = Timer.periodic(const Duration(milliseconds: 545), (timer) {
          setState(() => _beatCount++);
        });
      } else {
        _metronomeTimer?.cancel();
        _beatCount = 0;
      }
    });
  }

  @override
  void dispose() {
    _metronomeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EMERGENCY / CPR'),
        actions: [
          IconButton(
            icon: Icon(metronomeActive ? Icons.notifications_active : Icons.notifications_none, color: metronomeActive ? Colors.yellowAccent : Colors.white),
            onPressed: _toggleMetronome,
            tooltip: 'CPR Metronome (110 BPM)',
          )
        ],
      ),
      body: Column(
        children: [
          if (metronomeActive) _buildMetronomeHud(),
          _buildWeightInput(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: emergencyDrugData.length,
              itemBuilder: (context, index) => _buildDrugCard(emergencyDrugData[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetronomeHud() {
    return Container(
      width: double.infinity,
      color: Colors.redAccent.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _beatCount % 2 == 0 ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: const Icon(Icons.favorite, color: Colors.redAccent),
            ),
            const SizedBox(width: 12),
            const Text('CPR METRONOME ACTIVE: 110 BPM', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightInput() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.red.withOpacity(0.05),
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'PATIENT WEIGHT (KG)',
          labelStyle: TextStyle(color: Colors.redAccent, letterSpacing: 2),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
          prefixIcon: Icon(Icons.monitor_weight, color: Colors.redAccent, size: 32),
        ),
        onChanged: (val) => setState(() => weight = double.tryParse(val) ?? 0),
      ),
    );
  }

  Widget _buildDrugCard(EmergencyDrug drug) {
    double concentrationValue = double.parse(drug.concentration.split(' ').first);
    double volume = (weight > 0) ? (drug.doseMgPerKg * weight) / concentrationValue : 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlowCard(
        glowColor: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(drug.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(drug.indication, style: const TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Conc: ${drug.concentration} | Dose: ${drug.doseMgPerKg} mg/kg', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.redAccent)),
                child: Column(
                  children: [
                    Text(volume.toStringAsFixed(2), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'monospace')),
                    const Text('ML', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
