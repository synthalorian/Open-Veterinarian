import 'package:flutter/material.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';
import '../../services/database_service.dart';
import 'data/drug_reference.dart';
import 'drug_detail_view.dart';

class DrugFormularyView extends StatefulWidget {
  const DrugFormularyView({super.key});

  @override
  State<DrugFormularyView> createState() => _DrugFormularyViewState();
}

class _DrugFormularyViewState extends State<DrugFormularyView> {
  String selectedSpecies = 'canine';
  late List<DrugReference> allDrugs;

  @override
  void initState() {
    super.initState();
    allDrugs = DatabaseService.getDrugsBox().values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drug Formulary'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: selectedSpecies,
              underline: const SizedBox(),
              icon: Icon(Icons.pets, color: appColors.accent),
              items: const [
                DropdownMenuItem(value: 'canine', child: Text('Canine')),
                DropdownMenuItem(value: 'feline', child: Text('Feline')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => selectedSpecies = val);
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allDrugs.length,
        itemBuilder: (context, index) {
          final drug = allDrugs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DrugDetailView(drug: drug))),
              leading: Icon(Icons.medication, color: appColors.accent),
              title: Text(drug.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(drug.category, style: TextStyle(fontSize: 12, color: appColors.textDim)),
              trailing: Icon(Icons.chevron_right, color: appColors.textDim),
            ),
          );
        },
      ),
    );
  }
}