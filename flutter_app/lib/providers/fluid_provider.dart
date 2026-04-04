import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/calculator/fluid_calculator.dart';

part 'fluid_provider.g.dart';

class FluidState {
  final double weight;
  final double dehydration;
  final double hours;
  final double maintenanceConstant;
  final double ongoingLosses;
  final String selectedSpecies;
  final FluidCalculation? result;

  FluidState({
    this.weight = 0,
    this.dehydration = 0,
    this.hours = 24,
    this.maintenanceConstant = 60,
    this.ongoingLosses = 0,
    this.selectedSpecies = 'Canine',
    this.result,
  });

  FluidState copyWith({
    double? weight,
    double? dehydration,
    double? hours,
    double? maintenanceConstant,
    double? ongoingLosses,
    String? selectedSpecies,
    FluidCalculation? result,
  }) {
    return FluidState(
      weight: weight ?? this.weight,
      dehydration: dehydration ?? this.dehydration,
      hours: hours ?? this.hours,
      maintenanceConstant: maintenanceConstant ?? this.maintenanceConstant,
      ongoingLosses: ongoingLosses ?? this.ongoingLosses,
      selectedSpecies: selectedSpecies ?? this.selectedSpecies,
      result: result ?? this.result,
    );
  }
}

@riverpod
class FluidCalculatorNotifier extends _$FluidCalculatorNotifier {
  @override
  FluidState build() => FluidState();

  void updateWeight(double val) {
    state = state.copyWith(weight: val);
    _calculate();
  }

  void updateDehydration(double val) {
    state = state.copyWith(dehydration: val);
    _calculate();
  }

  void updateHours(double val) {
    state = state.copyWith(hours: val);
    _calculate();
  }

  void updateOngoingLosses(double val) {
    state = state.copyWith(ongoingLosses: val);
    _calculate();
  }

  void selectSpecies(String species) {
    double constant = (species == 'Canine') ? 60.0 : 45.0;
    state = state.copyWith(selectedSpecies: species, maintenanceConstant: constant);
    _calculate();
  }

  void updateMaintenanceConstant(double val) {
    state = state.copyWith(maintenanceConstant: val);
    _calculate();
  }

  void _calculate() {
    if (state.weight > 0) {
      final baseResult = FluidCalculator.calculate(
        bodyWeight: state.weight,
        percentDehydration: state.dehydration / 100,
        replacementHours: state.hours,
        maintenanceConstant: state.maintenanceConstant,
      );

      // Add ongoing losses to total daily rate
      final totalDailyWithLosses = baseResult.totalDailyRate + state.ongoingLosses;
      
      final finalResult = FluidCalculation(
        maintenanceRate: baseResult.maintenanceRate,
        replacementDeficit: baseResult.replacementDeficit,
        ongoingLosses: state.ongoingLosses,
        totalDailyRate: totalDailyWithLosses,
      );

      state = state.copyWith(result: finalResult);
    }
  }
}
