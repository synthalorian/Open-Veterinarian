import 'package:flutter/foundation.dart';

@immutable
class FluidCalculation {
  final double maintenanceRate; // ml/day
  final double replacementDeficit; // ml (over time)
  final double ongoingLosses; // ml/hr
  final double totalDailyRate; // ml/day

  const FluidCalculation({
    required this.maintenanceRate,
    required this.replacementDeficit,
    required this.ongoingLosses,
    required this.totalDailyRate,
  });

  @override
  String toString() => '${(totalDailyRate / 24).toStringAsFixed(1)} ml/hr';
}

class FluidCalculator {
  // Maintenance formula: (kg^0.75) * 132 (canine) or * 80 (feline)
  // Simplified canine: 60 ml/kg/day
  // Simplified feline: 40-50 ml/kg/day

  static FluidCalculation calculate({
    required double bodyWeight, // kg
    required double percentDehydration, // 0.05 for 5%
    required double replacementHours, // e.g., 24
    required double maintenanceConstant, // e.g., 60 for dogs
  }) {
    final maintenance = bodyWeight * maintenanceConstant;
    final deficit = bodyWeight * percentDehydration * 1000; // 1 kg = 1 L = 1000 ml
    final hourlyDeficit = deficit / replacementHours;

    final totalDaily = maintenance + (hourlyDeficit * 24);

    return FluidCalculation(
      maintenanceRate: maintenance,
      replacementDeficit: deficit,
      ongoingLosses: 0, // Placeholder
      totalDailyRate: totalDaily,
    );
  }
}

class DripRateCalculator {
  static double calculateDropsPerMinute({
    required double mlPerHour,
    required int dripFactor, // gtt/ml
  }) {
    return (mlPerHour * dripFactor) / 60;
  }
}
