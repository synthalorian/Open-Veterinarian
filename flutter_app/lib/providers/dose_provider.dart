import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/reference/data/drug_reference.dart';
import '../features/calculator/dose_calculator.dart';

part 'dose_provider.g.dart';

class DoseState {
  final double weight;
  final DrugReference? selectedDrug;
  final String? selectedSpecies;
  final DoseResult? result;

  DoseState({
    this.weight = 0,
    this.selectedDrug,
    this.selectedSpecies,
    this.result,
  });

  DoseState copyWith({
    double? weight,
    DrugReference? selectedDrug,
    String? selectedSpecies,
    DoseResult? result,
  }) {
    return DoseState(
      weight: weight ?? this.weight,
      selectedDrug: selectedDrug ?? this.selectedDrug,
      selectedSpecies: selectedSpecies ?? this.selectedSpecies,
      result: result ?? this.result,
    );
  }
}

@riverpod
class DoseCalculatorNotifier extends _$DoseCalculatorNotifier {
  @override
  DoseState build() => DoseState();

  void updateWeight(double val) {
    state = state.copyWith(weight: val);
    _calculate();
  }

  void selectDrug(DrugReference drug) {
    state = state.copyWith(selectedDrug: drug);
    _calculate();
  }

  void selectSpecies(String species) {
    state = state.copyWith(selectedSpecies: species);
    _calculate();
  }

  void _calculate() {
    final drug = state.selectedDrug;
    final species = state.selectedSpecies;
    final weight = state.weight;

    if (drug != null && species != null && weight > 0) {
      final dosage = drug.speciesDosages[species.toLowerCase()];
      if (dosage != null) {
        // We use the min dosage for the initial calculation
        final res = DoseCalculator.calculateDose(
          bodyWeight: weight,
          dosageAmount: dosage.min,
          unit: dosage.unit,
          frequency: dosage.frequency,
          route: dosage.route,
        );
        state = state.copyWith(result: res);
      }
    }
  }
}
