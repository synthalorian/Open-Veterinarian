import 'package:flutter/foundation.dart';

@immutable
class EmergencyDrug {
  final String name;
  final String concentration; // e.g., "1 mg/ml"
  final double doseMgPerKg;
  final String indication;

  const EmergencyDrug({
    required this.name,
    required this.concentration,
    required this.doseMgPerKg,
    required this.indication,
  });
}

final List<EmergencyDrug> emergencyDrugData = [
  const EmergencyDrug(
    name: 'Epinephrine (Low Dose)',
    concentration: '1 mg/ml',
    doseMgPerKg: 0.01,
    indication: 'Cardiac Arrest / CPR',
  ),
  const EmergencyDrug(
    name: 'Epinephrine (High Dose)',
    concentration: '1 mg/ml',
    doseMgPerKg: 0.1,
    indication: 'Prolonged Cardiac Arrest',
  ),
  const EmergencyDrug(
    name: 'Atropine',
    concentration: '0.54 mg/ml',
    doseMgPerKg: 0.04,
    indication: 'Bradycardia / Asystole',
  ),
  const EmergencyDrug(
    name: 'Lidocaine',
    concentration: '20 mg/ml',
    doseMgPerKg: 2.0,
    indication: 'V-Tach (Canine only)',
  ),
  const EmergencyDrug(
    name: 'Naloxone',
    concentration: '0.4 mg/ml',
    doseMgPerKg: 0.04,
    indication: 'Opioid Reversal',
  ),
  const EmergencyDrug(
    name: 'Dextrose 50%',
    concentration: '500 mg/ml',
    doseMgPerKg: 500, // 0.5 - 1 g/kg (dilute 1:1)
    indication: 'Hypoglycemia',
  ),
];
