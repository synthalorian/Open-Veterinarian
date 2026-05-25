import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/dose_provider.dart';
import '../../services/database_service.dart';
import '../reference/data/drug_reference.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';

class DoseCalculatorView extends ConsumerWidget {
  const DoseCalculatorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final state = ref.watch(doseCalculatorNotifierProvider);
    final notifier = ref.read(doseCalculatorNotifierProvider.notifier);
    final drugs = DatabaseService.getDrugsBox().values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dose Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPatientInfoCard(context, notifier, state, appColors),
            const SizedBox(height: 16),
            _buildDrugSelectorCard(context, notifier, state, drugs, appColors),
            const SizedBox(height: 20),
            if (state.result != null) _buildResultCard(context, state, appColors),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfoCard(BuildContext context, DoseCalculatorNotifier notifier, DoseState state, AppColors appColors) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.accent)),
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
            const Text('Species'),
            Row(
              children: [
                _buildSpeciesChip(notifier, state, 'Canine', Icons.pets, appColors),
                const SizedBox(width: 8),
                _buildSpeciesChip(notifier, state, 'Feline', Icons.pets, appColors),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeciesChip(DoseCalculatorNotifier notifier, DoseState state, String label, IconData icon, AppColors appColors) {
    final isSelected = state.selectedSpecies == label;
    return ChoiceChip(
      avatar: Icon(icon, size: 18, color: isSelected ? appColors.surface : appColors.accent),
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) notifier.selectSpecies(label);
      },
      selectedColor: appColors.accent,
    );
  }

  Widget _buildDrugSelectorCard(BuildContext context, DoseCalculatorNotifier notifier, DoseState state, List<DrugReference> drugs, AppColors appColors) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Medication', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.accent)),
            const SizedBox(height: 16),
            DropdownButtonFormField<DrugReference>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medication),
              ),
              hint: const Text('Search Drug Formulary'),
              value: state.selectedDrug,
              items: drugs.map((drug) {
                return DropdownMenuItem(
                  value: drug,
                  child: Text(drug.name),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) notifier.selectDrug(val);
              },
            ),
            if (state.selectedDrug != null) ...[
              const SizedBox(height: 12),
              Text(
                state.selectedDrug!.description,
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: appColors.textDim),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, DoseState state, AppColors appColors) {
    final res = state.result!;
    final drug = state.selectedDrug!;
    final speciesKey = state.selectedSpecies!.toLowerCase();
    final dosage = drug.speciesDosages[speciesKey]!;

    return Card(
      color: appColors.card,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Dose Calculation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: appColors.accent)),
            Divider(color: appColors.accentSecondary),
            _buildResultRow('Medication', drug.name),
            _buildResultRow('Recommended Dosage', '${dosage.min}-${dosage.max} ${dosage.unit}'),
            _buildResultRow('Route / Frequency', '${dosage.route} / ${dosage.frequency}'),
            Divider(color: appColors.accentSecondary),
            Text(
              'CALCULATED DOSE: ${res.dose} ${res.unit}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appColors.accent),
            ),
            const SizedBox(height: 8),
            Text(
              '(Based on minimum dosage of ${dosage.min} ${dosage.unit})',
              style: TextStyle(fontSize: 12, color: appColors.textDim),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}