import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'dental.g.dart';

@immutable
@HiveType(typeId: 18)
class DentalPathology extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String classification; // Stage 1-4
  @HiveField(3)
  final String treatment;

  DentalPathology({
    required this.name,
    required this.description,
    required this.classification,
    required this.treatment,
  });
}

final List<DentalPathology> initialDentalData = [
  DentalPathology(
    name: 'Periodontal Disease',
    description: 'Inflammation and destruction of the supporting structures of the teeth.',
    classification: 'Stage 1 (Gingivitis) to Stage 4 (Advanced Loss)',
    treatment: 'Scale & Polish (COHAT), extractions if Stage 4.',
  ),
  DentalPathology(
    name: 'FORL (Feline Resorptive Lesions)',
    description: 'Odontoclasts resorbing tooth structure, typically at the neck/root.',
    classification: 'TR Stage 1-5',
    treatment: 'Extraction of the affected tooth.',
  ),
];
