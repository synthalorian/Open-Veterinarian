import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../services/database_service.dart';
import '../theme/app_theme.dart';
import '../ui/glow_card.dart';
import 'patient_lab_log.dart';

class LaboratoryLogsView extends StatelessWidget {
  const LaboratoryLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('LABORATORY LOGS'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_chart, color: appColors.accent),
            onPressed: () => _showAddLogDialog(context),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: DatabaseService.getLabLogBox().listenable(),
        builder: (context, Box<PatientLabLog> box, _) {
          final logs = box.values.toList().reversed.toList();
          
          if (logs.isEmpty) {
            return Center(
              child: Text('No patient lab logs yet.', style: TextStyle(color: appColors.textDim)),
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
                  glowColor: appColors.accent,
                  child: ListTile(
                    title: Text(log.patientName.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent.withAlpha(204))),
                    subtitle: Text('${log.date.day}/${log.date.month}/${log.date.year}', style: TextStyle(fontSize: 12, color: appColors.textDim)),
                    trailing: Icon(Icons.chevron_right, color: appColors.accent),
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
    final appColors = Theme.of(context).extension<AppColors>()!;
    final nameController = TextEditingController();
    final creaController = TextEditingController();
    final bunController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: appColors.surface,
        title: Text('NEW PATIENT LAB LOG', style: TextStyle(color: appColors.accent, fontSize: 16)),
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
    final appColors = Theme.of(context).extension<AppColors>()!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: appColors.surface,
        title: Text(log.patientName.toUpperCase(), style: TextStyle(color: appColors.accent)),
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
