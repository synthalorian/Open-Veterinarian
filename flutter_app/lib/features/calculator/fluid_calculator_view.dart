import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/fluid_provider.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';

class FluidCalculatorView extends ConsumerWidget {
  const FluidCalculatorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final state = ref.watch(fluidCalculatorNotifierProvider);
    final notifier = ref.read(fluidCalculatorNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluid Therapy Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputCard(context, notifier, state, appColors),
            const SizedBox(height: 20),
            if (state.result != null) _buildResultCard(context, state, appColors),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard(BuildContext context, FluidCalculatorNotifier notifier, FluidState state, AppColors appColors) {
    return Card(
      color: appColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: appColors.accent.withAlpha(51)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient Parameters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.accent)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSpeciesChip(notifier, state, 'Canine', appColors),
                const SizedBox(width: 12),
                _buildSpeciesChip(notifier, state, 'Feline', appColors),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Body Weight (kg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => notifier.updateWeight(double.tryParse(val) ?? 0),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Dehydration (%)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.water_damage),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => notifier.updateDehydration(double.tryParse(val) ?? 0),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Ongoing Losses (ml/day)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.warning_amber),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => notifier.updateOngoingLosses(double.tryParse(val) ?? 0),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Replacement Period (hours)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: '24')..selection = const TextSelection.collapsed(offset: 2),
              onChanged: (val) => notifier.updateHours(double.tryParse(val) ?? 24),
            ),
            const SizedBox(height: 16),
            const Text('Maintenance Constant (ml/kg/day)'),
            Slider(
              value: state.maintenanceConstant,
              min: 40,
              max: 80,
              divisions: 8,
              label: state.maintenanceConstant.round().toString(),
              activeColor: appColors.accent,
              onChanged: (val) => notifier.updateMaintenanceConstant(val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeciesChip(FluidCalculatorNotifier notifier, FluidState state, String species, AppColors appColors) {
    final isSelected = state.selectedSpecies == species;
    return ChoiceChip(
      label: Text(species),
      selected: isSelected,
      onSelected: (val) => (val) ? notifier.selectSpecies(species) : null,
      selectedColor: appColors.accent,
      labelStyle: TextStyle(color: isSelected ? appColors.surface : appColors.accent),
    );
  }

  Widget _buildResultCard(BuildContext context, FluidState state, AppColors appColors) {
    final res = state.result!;
    return Card(
      color: appColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: appColors.accentSecondary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Calculation Results', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: appColors.accent)),
            Divider(color: appColors.accentSecondary),
            _buildResultRow('Maintenance Rate', '${res.maintenanceRate.toStringAsFixed(1)} ml/day', appColors),
            _buildResultRow('Replacement Deficit', '${res.replacementDeficit.toStringAsFixed(1)} ml', appColors),
            _buildResultRow('Ongoing Losses', '${res.ongoingLosses.toStringAsFixed(1)} ml/day', appColors),
            Divider(color: appColors.accentSecondary),
            Text(
              'TOTAL RATE: ${res.toString()}',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: appColors.accent),
            ),
            const SizedBox(height: 8),
            Text(
              '(Maintenance + Deficit + Ongoing Losses)',
              style: TextStyle(fontSize: 10, color: appColors.textDim),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}