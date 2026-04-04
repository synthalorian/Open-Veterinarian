import 'package:hive/hive.dart';

part 'patient_lab_log.g.dart';

@HiveType(typeId: 16)
class PatientLabLog extends HiveObject {
  @HiveField(0)
  final String patientName;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final Map<String, double> results; // e.g., {'CREA': 1.2, 'BUN': 20.0}
  @HiveField(3)
  final String notes;

  PatientLabLog({
    required this.patientName,
    required this.date,
    required this.results,
    this.notes = '',
  });
}
