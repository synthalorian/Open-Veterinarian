import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'lab_reference.g.dart';

@immutable
@HiveType(typeId: 4)
class LabRange {
  @HiveField(0)
  final double min;
  @HiveField(1)
  final double max;
  @HiveField(2)
  final String unit;

  const LabRange({required this.min, required this.max, required this.unit});

  @override
  String toString() => '$min - $max $unit';
}

@immutable
@HiveType(typeId: 5)
class LabTest extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String abbreviation;
  @HiveField(2)
  final String category; // e.g., Hematology, Chemistry, Electrolytes
  @HiveField(3)
  final Map<String, LabRange> speciesRanges; // key: 'canine', 'feline'

  LabTest({
    required this.name,
    required this.abbreviation,
    required this.category,
    required this.speciesRanges,
  });
}

// Initial Lab Data Seed
final List<LabTest> initialLabData = [
  LabTest(
    name: 'Creatinine',
    abbreviation: 'CREA',
    category: 'Chemistry (Renal)',
    speciesRanges: {
      'canine': const LabRange(min: 0.5, max: 1.8, unit: 'mg/dL'),
      'feline': const LabRange(min: 0.8, max: 2.4, unit: 'mg/dL'),
    },
  ),
  LabTest(
    name: 'Blood Urea Nitrogen',
    abbreviation: 'BUN',
    category: 'Chemistry (Renal)',
    speciesRanges: {
      'canine': const LabRange(min: 7.0, max: 27.0, unit: 'mg/dL'),
      'feline': const LabRange(min: 16.0, max: 36.0, unit: 'mg/dL'),
    },
  ),
  LabTest(
    name: 'White Blood Cell Count',
    abbreviation: 'WBC',
    category: 'Hematology',
    speciesRanges: {
      'canine': const LabRange(min: 5.0, max: 16.7, unit: 'x10^3/μL'),
      'feline': const LabRange(min: 5.5, max: 19.5, unit: 'x10^3/μL'),
    },
  ),
  LabTest(
    name: 'Alanine Aminotransferase',
    abbreviation: 'ALT',
    category: 'Chemistry (Liver)',
    speciesRanges: {
      'canine': const LabRange(min: 10, max: 125, unit: 'U/L'),
      'feline': const LabRange(min: 12, max: 130, unit: 'U/L'),
    },
  ),
  LabTest(
    name: 'Glucose',
    abbreviation: 'GLU',
    category: 'Chemistry',
    speciesRanges: {
      'canine': const LabRange(min: 70, max: 143, unit: 'mg/dL'),
      'feline': const LabRange(min: 71, max: 159, unit: 'mg/dL'),
    },
  ),
  LabTest(
    name: 'Total Protein',
    abbreviation: 'TP',
    category: 'Chemistry',
    speciesRanges: {
      'canine': const LabRange(min: 5.2, max: 8.2, unit: 'g/dL'),
      'feline': const LabRange(min: 5.7, max: 8.9, unit: 'g/dL'),
    },
  ),
  LabTest(
    name: 'Calcium',
    abbreviation: 'CA',
    category: 'Electrolytes',
    speciesRanges: {
      'canine': const LabRange(min: 7.9, max: 12.0, unit: 'mg/dL'),
      'feline': const LabRange(min: 7.8, max: 11.3, unit: 'mg/dL'),
    },
  ),
  LabTest(
    name: 'Potassium',
    abbreviation: 'K',
    category: 'Electrolytes',
    speciesRanges: {
      'canine': const LabRange(min: 3.5, max: 5.8, unit: 'mmol/L'),
      'feline': const LabRange(min: 3.5, max: 5.8, unit: 'mmol/L'),
    },
  ),
];
