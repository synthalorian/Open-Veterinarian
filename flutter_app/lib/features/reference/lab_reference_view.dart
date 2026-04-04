import 'package:flutter/material.dart';
import '../reference/data/lab_reference.dart';
import 'lab_detail_view.dart';

class LabReferenceView extends StatefulWidget {
  const LabReferenceView({super.key});

  @override
  State<LabReferenceView> createState() => _LabReferenceViewState();
}

class _LabReferenceViewState extends State<LabReferenceView> {
  String selectedSpecies = 'canine';

  @override
  Widget build(BuildContext context) {
    // Group tests by category
    final Map<String, List<LabTest>> categorizedTests = {};
    for (var test in initialLabData) {
      categorizedTests.putIfAbsent(test.category, () => []).add(test);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Reference Ranges'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: selectedSpecies,
              underline: const SizedBox(),
              icon: const Icon(Icons.pets, color: Colors.cyanAccent),
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: categorizedTests.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  entry.key.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
              ...entry.value.map((test) => _buildLabCard(test)),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLabCard(LabTest test) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LabDetailView(lab: test))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(test.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(test.abbreviation, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
