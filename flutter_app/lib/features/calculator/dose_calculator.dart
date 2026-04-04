import 'package:flutter/foundation.dart';

@immutable
class DoseResult {
  final double dose;
  final String unit;
  final String frequency;
  final String route;

  const DoseResult({
    required this.dose,
    required this.unit,
    required this.frequency,
    required this.route,
  });

  @override
  String toString() => '$dose $unit ($route, $frequency)';
}

class DoseCalculator {
  static DoseResult calculateDose({
    required double bodyWeight, // kg
    required double dosageAmount, // e.g., 0.1 (mg/kg)
    required String unit,
    String frequency = 'N/A',
    String route = 'N/A',
  }) {
    final double result = bodyWeight * dosageAmount;
    return DoseResult(
      dose: double.parse(result.toStringAsFixed(2)),
      unit: unit.split('/').first, // extracts 'mg' from 'mg/kg'
      frequency: frequency,
      route: route,
    );
  }

  // Future expansion: Fluid rate calculators (ml/hr), etc.
}
