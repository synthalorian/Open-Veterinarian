import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../services/database_service.dart';
import 'surgical_checklist.dart';

class AnesthesiaChecklistView extends StatelessWidget {
  const AnesthesiaChecklistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anesthesia Checklist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Checklist',
            onPressed: () => _resetChecklist(context),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: DatabaseService.getChecklistBox().listenable(),
        builder: (context, Box<SurgicalChecklist> box, _) {
          final phases = box.values.toList();
          
          if (phases.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: phases.length,
            itemBuilder: (context, index) {
              final phase = phases[index];
              return _buildPhaseGroup(context, phase);
            },
          );
        },
      ),
    );
  }

  Widget _buildPhaseGroup(BuildContext context, SurgicalChecklist phase) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            phase.phase.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.cyanAccent,
            ),
          ),
        ),
        ...phase.items.asMap().entries.map((entry) {
          final item = entry.value;
          return Card(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: CheckboxListTile(
              title: Text(item.task),
              value: item.isCompleted,
              activeColor: Colors.cyanAccent,
              checkColor: Colors.black,
              onChanged: (bool? value) {
                item.isCompleted = value ?? false;
                phase.save(); // Persist change via Hive
              },
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  void _resetChecklist(BuildContext context) async {
    final box = DatabaseService.getChecklistBox();
    for (var phase in box.values) {
      for (var item in phase.items) {
        item.isCompleted = false;
      }
      await phase.save();
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checklist reset for next surgery.')),
      );
    }
  }
}
