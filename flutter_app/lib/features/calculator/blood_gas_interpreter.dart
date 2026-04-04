import 'package:flutter/foundation.dart';

@immutable
class BloodGasResult {
  final String primaryDisturbance;
  final String compensation;
  final String interpretation;

  const BloodGasResult({
    required this.primaryDisturbance,
    required this.compensation,
    required this.interpretation,
  });
}

class BloodGasInterpreter {
  static BloodGasResult interpret({
    required double ph,
    required double pco2, // mmHg
    required double hco3, // mEq/L
  }) {
    // Normal Ranges (Dog): pH 7.35-7.45, pCO2 35-45, HCO3 18-24
    
    String primary = 'Normal';
    String comp = 'None';
    String details = 'Acid-base balance within normal limits.';

    if (ph < 7.35) {
      // Acidosis
      if (pco2 > 45 && hco3 >= 18) {
        primary = 'Respiratory Acidosis';
        comp = hco3 > 24 ? 'Partial Compensation (Metabolic)' : 'Uncompensated';
        details = 'Increased CO2 suggests hypoventilation.';
      } else if (hco3 < 18 && pco2 <= 45) {
        primary = 'Metabolic Acidosis';
        comp = pco2 < 35 ? 'Partial Compensation (Respiratory)' : 'Uncompensated';
        details = 'Decreased HCO3 suggests metabolic acid gain or base loss.';
      }
    } else if (ph > 7.45) {
      // Alkalosis
      if (pco2 < 35 && hco3 <= 24) {
        primary = 'Respiratory Alkalosis';
        comp = hco3 < 18 ? 'Partial Compensation (Metabolic)' : 'Uncompensated';
        details = 'Decreased CO2 suggests hyperventilation.';
      } else if (hco3 > 24 && pco2 >= 35) {
        primary = 'Metabolic Alkalosis';
        comp = pco2 > 45 ? 'Partial Compensation (Respiratory)' : 'Uncompensated';
        details = 'Increased HCO3 suggests base gain or acid loss.';
      }
    }

    return BloodGasResult(
      primaryDisturbance: primary,
      compensation: comp,
      interpretation: details,
    );
  }
}
