import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'patient_lab_log.dart';

class LaboratoryLogsView extends StatelessWidget {
  const LaboratoryLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LABORATORY LOGS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_chart, color: Colors.cyanAccent),
            onPressed: () => _showAddLogDialog(context),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: DatabaseService.getLabLogBox().listenable(),
        builder: (context, Box<PatientLabLog> box, _) {
          final logs = box.values.toList().reversed.toList();
          
          if (logs.isEmpty) {
            return const Center(
              child: Text('No patient lab logs yet.', style: TextStyle(color: Colors.grey)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlowCard(
                  glowColor: Colors.blueAccent,
                  child: ListTile(
                    title: Text(log.patientName.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    subtitle: Text('${log.date.day}/${log.date.month}/${log.date.year}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.blueAccent),
                    onTap: () => _showLogDetail(context, log),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddLogDialog(BuildContext context) {
    final nameController = TextEditingController();
    final creaController = TextEditingController();
    final bunController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('NEW PATIENT LAB LOG', style: TextStyle(color: Colors.cyanAccent, fontSize: 16)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Patient Name')),
              TextField(controller: creaController, decoration: const InputDecoration(labelText: 'Creatinine (mg/dL)'), keyboardType: TextInputType.number),
              TextField(controller: bunController, decoration: const InputDecoration(labelText: 'BUN (mg/dL)'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              final newLog = PatientLabLog(
                patientName: nameController.text,
                date: DateTime.now(),
                results: {
                  'CREA': double.tryParse(creaController.text) ?? 0,
                  'BUN': double.tryParse(bunController.text) ?? 0,
                },
              );
              DatabaseService.getLabLogBox().add(newLog);
              Navigator.pop(context);
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  void _showLogDetail(BuildContext context, PatientLabLog log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(log.patientName.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: log.results.entries.map((e) => ListTile(
            title: Text(e.key),
            trailing: Text('${e.value}', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          )).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE')),
        ],
      ),
    );
  }
}
