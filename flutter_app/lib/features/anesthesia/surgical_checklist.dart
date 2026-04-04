import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'surgical_checklist.g.dart';

@HiveType(typeId: 6)
class ChecklistItem extends HiveObject {
  @HiveField(0)
  final String task;
  @HiveField(1)
  bool isCompleted;

  ChecklistItem({required this.task, this.isCompleted = false});
}

@HiveType(typeId: 7)
class SurgicalChecklist extends HiveObject {
  @HiveField(0)
  final String phase; // e.g., Pre-Op, Induction, Maintenance, Recovery
  @HiveField(1)
  final List<ChecklistItem> items;

  SurgicalChecklist({required this.phase, required this.items});
}

final List<SurgicalChecklist> initialChecklistData = [
  SurgicalChecklist(
    phase: 'Pre-Anesthetic / Prep',
    items: [
      ChecklistItem(task: 'Patient fasted (8-12 hours)'),
      ChecklistItem(task: 'Pre-op blood work reviewed'),
      ChecklistItem(task: 'Physical exam & weight verified'),
      ChecklistItem(task: 'IV catheter placed & patent'),
      ChecklistItem(task: 'Emergency drug doses calculated'),
    ],
  ),
  SurgicalChecklist(
    phase: 'Induction & Intubation',
    items: [
      ChecklistItem(task: 'ET tube size selected & cuff tested'),
      ChecklistItem(task: 'Laryngoscope functional'),
      ChecklistItem(task: 'Anesthesia machine leak test passed'),
      ChecklistItem(task: 'Induction agent administered'),
      ChecklistItem(task: 'ET tube secured & placement verified'),
    ],
  ),
  SurgicalChecklist(
    phase: 'Monitoring (Intra-Op)',
    items: [
      ChecklistItem(task: 'Pulse Oximetry (SpO2 > 95%)'),
      ChecklistItem(task: 'Capnography (EtCO2 35-45 mmHg)'),
      ChecklistItem(task: 'Blood Pressure monitored (MAP > 60 mmHg)'),
      ChecklistItem(task: 'Temperature monitored (active warming used)'),
      ChecklistItem(task: 'Reflexes & Jaw tone checked'),
    ],
  ),
  SurgicalChecklist(
    phase: 'Recovery',
    items: [
      ChecklistItem(task: 'Gas turned off, 100% O2 for 5 min'),
      ChecklistItem(task: 'Temperature checked (Warming continued)'),
      ChecklistItem(task: 'Pain management administered'),
      ChecklistItem(task: 'Extubated after 2 swallows'),
      ChecklistItem(task: 'Patient sternal and comfortable'),
    ],
  ),
];
